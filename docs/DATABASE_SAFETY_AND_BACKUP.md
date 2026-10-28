# VisitNepal Database Safety, Backup & Disaster Recovery Strategy

## 1. Architectural Guarantee: No Volatile Fallback in Production
In production (`NODE_ENV === 'production'`), VisitNepal enforces a strict zero-volatile-storage rule:
- `backend/src/db.ts` rejects any fallback to in-memory tables when `NODE_ENV === 'production'`.
- If the primary PostgreSQL instance is unreachable, the API returns structured HTTP 503 (`Database Unavailable`) via the `/health/db` endpoint.
- Bookings, payments, permits, financial transactions, and KYC documents are never stored in volatile memory in production.

## 2. PostgreSQL Backup Strategy

### Continuous Archiving & Point-In-Time-Recovery (PITR)
- **WAL Archiving**: Continuous archiving of PostgreSQL Write-Ahead Logs (WAL) to an immutable, multi-region Amazon S3 / Google Cloud Storage bucket.
- **RPO (Recovery Point Objective)**: Under 5 minutes.
- **RTO (Recovery Time Objective)**: Under 30 minutes.

### Automated Daily Snapshot Schedule
```bash
# Automated daily cron backup at 02:00 NPT (UTC+5:45)
pg_dump -h $DB_HOST -U $DB_USER -d $DB_NAME -F c -b -v -f "/backups/visitnepal_$(date +\%Y\%m\%d_\%H\%M\%S).dump"
```
- Retention Policy:
  - Daily dumps retained for 30 days.
  - Weekly snapshots retained for 90 days.
  - Monthly archives retained for 7 years for financial and tax auditing compliance.

## 3. Disaster Recovery Procedure
In the event of database instance failure:
1. Provision new PostgreSQL cluster with identical schema extensions (`pgcrypto`, `btree_gist`).
2. Restore latest base backup:
   ```bash
   pg_restore -h $NEW_DB_HOST -U $DB_USER -d $DB_NAME -v "/backups/latest.dump"
   ```
3. Replay WAL logs up to the desired timestamp.
4. Verify table row counts and foreign key integrity.
5. Update `DATABASE_URL` in environment secrets.
6. Check `/health/db` on the API server to confirm status: `healthy`.

## 4. Transaction Integrity & Double-Entry Ledger
All financial operations (booking payments, refunds, payouts, platform commission splits) are executed inside atomic ACID transactions:
- Isolation Level: `READ COMMITTED` with `SELECT ... FOR UPDATE` row-level locks on inventory slots.
- Mathematical Safety: Numeric-safe currency arithmetic in `finance.service.ts` using 2-decimal cents/paisa rounding to eliminate IEEE-754 floating-point drift.
