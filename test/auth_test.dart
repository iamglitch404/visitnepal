import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isValidPhone(String phone) {
  final cleanPhone = phone.replaceAll(RegExp(r'[\s\-()]'), '');
  return cleanPhone.length >= 7 && RegExp(r'^\+?[0-9]+$').hasMatch(cleanPhone);
}

bool isValidPasswordComplexity(String pwd) {
  if (pwd.length < 8) return false;
  if (!RegExp(r'[A-Z]').hasMatch(pwd)) return false;
  if (!RegExp(r'[a-z]').hasMatch(pwd)) return false;
  if (!RegExp(r'[0-9]').hasMatch(pwd)) return false;
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd)) return false;
  return true;
}

void main() {
  group('Authentication Validation Logic Tests', () {
    test('Email regex validation works correctly', () {
      expect(isValidEmail('aayush.traveler@visitnepal.com'), isTrue);
      expect(isValidEmail('pasang.sherpa@visitnepal.com'), isTrue);
      expect(isValidEmail('officer@ntb.gov.np'), isTrue);
      expect(isValidEmail('invalid-email'), isFalse);
    });

    test('Phone number validation works correctly', () {
      expect(isValidPhone('+977 9841234567'), isTrue);
      expect(isValidPhone('+977 9801122334'), isTrue);
      expect(isValidPhone('123'), isFalse);
    });

    test('Strong password complexity rules enforce security', () {
      expect(isValidPasswordComplexity('Pass@1234'), isTrue);
      expect(isValidPasswordComplexity('password'), isFalse);
      expect(isValidPasswordComplexity('PASS1234!'), isFalse);
    });
  });
}
