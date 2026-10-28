import 'package:flutter/material.dart';
import '../../../core/data/mockData.dart';
import '../../../core/widgets/designSystem.dart';
import '../../traveler/main/screens/mainScreen.dart';
import '../../business/screens/businessDashboardScreen.dart';
import '../../admin/screens/adminDashboardScreen.dart';

enum UserRole { traveler, business, admin }

class LoginScreen extends StatefulWidget {
  final UserRole initialRole;

  const LoginScreen({
    super.key,
    this.initialRole = UserRole.traveler,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserRole _selectedRole;
  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _rememberMe = true;

  // 4-Step Registration State for Sign Up
  int _signUpStep = 1; // 1: Details, 2: OTP, 3: Role Documents, 4: Welcome Preferences

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _businessNameCtrl = TextEditingController();
  final TextEditingController _adminBadgeCtrl = TextEditingController();

  // Step 3: Traveler Document Controllers
  final TextEditingController _nationalityCtrl = TextEditingController(text: 'United States');
  final TextEditingController _passportCtrl = TextEditingController(text: 'US-99882211');
  final TextEditingController _emergencyCtrl = TextEditingController(text: 'John Smith (+1 415 555 0199)');
  final TextEditingController _bloodCtrl = TextEditingController(text: 'O+');
  String _visaType = 'On-Arrival Tourist Visa (30 Days)';

  // Step 3: Business & Government Document Controllers (Nagarikta / NID)
  final TextEditingController _regCtrl = TextEditingController(text: 'CRO-9988221');
  final TextEditingController _panCtrl = TextEditingController(text: 'PAN-601234567');
  final TextEditingController _citizenshipCtrl = TextEditingController(text: 'NPL-27-01-78-01234');
  String _businessLicenseType = 'Hotel & Resort License (HAN)';

  bool _docUploaded = true;

  // 6-digit OTP controllers
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  final Set<String> _selectedInterests = {'Trekking', 'Culture', 'Lakes & Valleys'};

  final List<Map<String, dynamic>> _interestsOptions = const [
    {'label': 'Trekking', 'icon': Icons.hiking_rounded},
    {'label': 'Culture', 'icon': Icons.temple_buddhist_rounded},
    {'label': 'Adventure', 'icon': Icons.paragliding_rounded},
    {'label': 'Wildlife', 'icon': Icons.pets_rounded},
    {'label': 'Spiritual', 'icon': Icons.self_improvement_rounded},
    {'label': 'Lakes & Valleys', 'icon': Icons.water_rounded},
    {'label': 'Food & Tea', 'icon': Icons.coffee_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
    _fillDefaultCredentials();
    _prefillOtpCode();
  }

  void _prefillOtpCode() {
    const defaultOtp = '123456';
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].text = defaultOtp[i];
    }
  }

  void _fillDefaultCredentials() {
    switch (_selectedRole) {
      case UserRole.traveler:
        _emailCtrl.text = MockData.currentUser['email'] ?? 'aayush.traveler@visitnepal.com';
        _passwordCtrl.text = 'Pass@1234';
        _nameCtrl.text = MockData.currentUser['name'] ?? 'Aayush Pradhan';
        _phoneCtrl.text = MockData.currentUser['phone'] ?? '+977 9841234567';
        break;
      case UserRole.business:
        _emailCtrl.text = 'partner@himalayanexpeditions.com';
        _passwordCtrl.text = 'Pass@1234';
        _nameCtrl.text = 'Pasang Nuru Sherpa';
        _phoneCtrl.text = '+977 9812345678';
        _businessNameCtrl.text = 'Himalayan Sherpa Expeditions Pvt. Ltd.';
        break;
      case UserRole.admin:
        _emailCtrl.text = 'officer@ntb.gov.np';
        _passwordCtrl.text = 'Pass@1234';
        _nameCtrl.text = 'Kritish Shrestha (NTB Officer)';
        _phoneCtrl.text = '+977 1 4247037';
        _adminBadgeCtrl.text = 'NTB-OFFICER-9981';
        break;
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _businessNameCtrl.dispose();
    _adminBadgeCtrl.dispose();
    _nationalityCtrl.dispose();
    _passportCtrl.dispose();
    _emergencyCtrl.dispose();
    _bloodCtrl.dispose();
    _regCtrl.dispose();
    _panCtrl.dispose();
    _citizenshipCtrl.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-()]'), '');
    return cleanPhone.length >= 7 && RegExp(r'^\+?[0-9]+$').hasMatch(cleanPhone);
  }

  void _showForgotPasswordDialog() {
    final resetEmailCtrl = TextEditingController(text: _selectedRole == UserRole.admin ? _adminBadgeCtrl.text : _emailCtrl.text);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.lock_reset_rounded, color: Color(0xFF0552A2)),
            SizedBox(width: 8),
            Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedRole == UserRole.admin
                  ? "Enter your NTB Officer Badge / Gov ID Number to receive password reset instructions."
                  : "Enter your registered account email and we'll send password recovery instructions.",
              style: const TextStyle(fontSize: 12.5, height: 1.35, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: resetEmailCtrl,
              decoration: InputDecoration(
                labelText: _selectedRole == UserRole.admin ? 'Gov ID / Badge Number' : 'Account Email',
                prefixIcon: Icon(_selectedRole == UserRole.admin ? Icons.badge_outlined : Icons.email_outlined, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0552A2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              final textVal = resetEmailCtrl.text.trim();
              if (textVal.isEmpty) {
                AppFeedback.showInfo(context, 'Please enter your ID/email.');
                return;
              }
              Navigator.pop(ctx);
              AppFeedback.showSuccess(context, 'Password reset link sent to $textVal');
            },
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }

  void _handleStep1Submit() {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (name.isEmpty || name.length < 2) {
      AppFeedback.showInfo(context, 'Full Name is required (at least 2 characters).');
      return;
    }

    if (_selectedRole == UserRole.business && _businessNameCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'Business / Agency Name is required.');
      return;
    }

    if (_selectedRole == UserRole.admin && _adminBadgeCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'NTB Officer Badge / Gov ID Number is required.');
      return;
    }

    if (_selectedRole != UserRole.admin && (email.isEmpty || !_isValidEmail(email))) {
      AppFeedback.showInfo(context, 'Valid Email Address is required.');
      return;
    }

    if (phone.isEmpty || !_isValidPhone(phone)) {
      AppFeedback.showInfo(context, 'Valid Phone Number is required.');
      return;
    }

    // Password Complexity Rules
    if (password.length < 8) {
      AppFeedback.showInfo(context, 'Password must be at least 8 characters long.');
      return;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      AppFeedback.showInfo(context, 'Password requires at least 1 uppercase letter (A-Z).');
      return;
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      AppFeedback.showInfo(context, 'Password requires at least 1 lowercase letter (a-z).');
      return;
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      AppFeedback.showInfo(context, 'Password requires at least 1 numeric digit (0-9).');
      return;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      AppFeedback.showInfo(context, 'Password requires at least 1 special symbol (e.g. @, #, \$, !).');
      return;
    }

    // Proceed to Step 2: Verification Code
    setState(() {
      _signUpStep = 2;
    });
    AppFeedback.showSuccess(context, '6-digit verification code sent to ${email.isEmpty ? phone : email}');
  }

  void _handleStep2Verify() {
    final otpCode = _otpControllers.map((c) => c.text.trim()).join();
    if (otpCode.length < 6) {
      AppFeedback.showInfo(context, 'Please enter the complete 6-digit verification code.');
      return;
    }

    // Proceed to Step 3: Role Documents
    setState(() {
      _signUpStep = 3;
    });
    AppFeedback.showSuccess(context, 'Code Verified!');
  }

  void _handleStep3SaveDocs() {
    if (_selectedRole == UserRole.business) {
      if (_citizenshipCtrl.text.trim().isEmpty) {
        AppFeedback.showInfo(context, 'NID (National ID) or Nagarikta Number is required to verify business owner.');
        return;
      }
      if (_regCtrl.text.trim().isEmpty || _panCtrl.text.trim().isEmpty) {
        AppFeedback.showInfo(context, 'Company Registration Number and PAN/VAT Number are required.');
        return;
      }

      AppFeedback.showSuccess(context, 'Business Legal Documents & Nagarikta/NID Verified!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const BusinessDashboardScreen()),
        (route) => false,
      );
      return;
    }

    if (_selectedRole == UserRole.admin) {
      if (_adminBadgeCtrl.text.trim().isEmpty) {
        AppFeedback.showInfo(context, 'NTB Officer Badge / Gov ID Number is required.');
        return;
      }

      AppFeedback.showSuccess(context, 'NTB Officer Badge & Gov ID Authorized!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
        (route) => false,
      );
      return;
    }

    if (_passportCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'Passport / Citizenship ID is required for tourist entry.');
      return;
    }

    // Save Traveler Data
    MockData.currentUser['name'] = _nameCtrl.text.trim();
    MockData.currentUser['email'] = _emailCtrl.text.trim();
    MockData.currentUser['phone'] = _phoneCtrl.text.trim();
    MockData.currentUser['nationality'] = _nationalityCtrl.text.trim();
    MockData.currentUser['passportNumber'] = _passportCtrl.text.trim();
    MockData.currentUser['emergencyContact'] = _emergencyCtrl.text.trim();
    MockData.currentUser['bloodGroup'] = _bloodCtrl.text.trim();

    // Proceed to Step 4: Welcome Preferences
    setState(() {
      _signUpStep = 4;
    });
    AppFeedback.showSuccess(context, 'Tourist Documents Verified with NTB!');
  }

  void _handleStep4Complete() {
    AppFeedback.showSuccess(context, 'Welcome to Nepal, ${_nameCtrl.text}!');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  void _handleAuthenticate() {
    if (_isSignUp) {
      if (_signUpStep == 1) {
        _handleStep1Submit();
      } else if (_signUpStep == 2) {
        _handleStep2Verify();
      } else if (_signUpStep == 3) {
        _handleStep3SaveDocs();
      } else if (_signUpStep == 4) {
        _handleStep4Complete();
      }
      return;
    }

    // Standard Sign In Validation
    final password = _passwordCtrl.text.trim();

    if (_selectedRole == UserRole.admin) {
      final badgeId = _adminBadgeCtrl.text.trim();
      if (badgeId.isEmpty) {
        AppFeedback.showInfo(context, 'Please enter your NTB Officer Badge / Gov ID Number.');
        return;
      }
      if (password.isEmpty) {
        AppFeedback.showInfo(context, 'Please enter your password.');
        return;
      }

      AppFeedback.showSuccess(context, 'Government NTB Officer ($badgeId) Authorized');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
        (route) => false,
      );
      return;
    }

    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      AppFeedback.showInfo(context, 'Please enter a valid email address.');
      return;
    }

    if (password.isEmpty) {
      AppFeedback.showInfo(context, 'Please enter your password.');
      return;
    }

    switch (_selectedRole) {
      case UserRole.traveler:
        AppFeedback.showSuccess(context, 'Signed in as ${_nameCtrl.text}');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
        break;

      case UserRole.business:
        AppFeedback.showSuccess(context, 'Welcome to Business Partner Portal');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BusinessDashboardScreen()),
          (route) => false,
        );
        break;

      case UserRole.admin:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final pwd = _passwordCtrl.text;
    final hasMinLength = pwd.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(pwd);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(pwd);
    final hasDigit = RegExp(r'[0-9]').hasMatch(pwd);
    final hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context) || (_isSignUp && _signUpStep > 1)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  if (_isSignUp && _signUpStep > 1) {
                    setState(() => _signUpStep--);
                  } else if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Logo Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/svg/logo.jpeg',
                        width: 38,
                        height: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VISIT NEPAL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const Text(
                        'Himalayan Travel & Portal',
                        style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Title Header
              Text(
                _isSignUp
                    ? (_signUpStep == 1
                        ? 'Create Account'
                        : (_signUpStep == 2
                            ? 'Verify Code'
                            : (_signUpStep == 3
                                ? (_selectedRole == UserRole.business
                                    ? 'Business & Nagarikta Verification'
                                    : (_selectedRole == UserRole.admin ? 'Government Officer ID' : 'Tourist Travel Docs'))
                                : 'Welcome to Nepal!')))
                    : 'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _isSignUp
                    ? (_signUpStep == 1
                        ? 'Step 1 of ${_selectedRole == UserRole.traveler ? 4 : 3}: Enter account details'
                        : (_signUpStep == 2
                            ? 'Step 2 of ${_selectedRole == UserRole.traveler ? 4 : 3}: Code sent to ${_emailCtrl.text.isEmpty ? _phoneCtrl.text : _emailCtrl.text}'
                            : (_signUpStep == 3
                                ? (_selectedRole == UserRole.business
                                    ? 'Step 3 of 3: Nagarikta / NID, Reg # & PAN'
                                    : (_selectedRole == UserRole.admin ? 'Step 3 of 3: NTB Officer Badge & Gov ID' : 'Step 3 of 4: Passport & Tourist Verification'))
                                : 'Step 4 of 4: Tailor your Himalayan experiences')))
                    : 'Select your access role to continue',
                style: TextStyle(
                  fontSize: 12.5,
                  color: isDark ? Colors.white60 : const Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 18),

              // Step Indicator Bar
              if (_isSignUp) ...[
                Row(
                  children: [
                    _buildStepBar(stepNum: 1, label: 'Details', activeStep: _signUpStep, isDark: isDark),
                    const SizedBox(width: 6),
                    _buildStepBar(stepNum: 2, label: 'Verify', activeStep: _signUpStep, isDark: isDark),
                    const SizedBox(width: 6),
                    _buildStepBar(
                      stepNum: 3,
                      label: _selectedRole == UserRole.business
                          ? 'Nagarikta & PAN'
                          : (_selectedRole == UserRole.admin ? 'Gov ID' : 'Passport'),
                      activeStep: _signUpStep,
                      isDark: isDark,
                    ),
                    if (_selectedRole == UserRole.traveler) ...[
                      const SizedBox(width: 6),
                      _buildStepBar(stepNum: 4, label: 'Explore', activeStep: _signUpStep, isDark: isDark),
                    ],
                  ],
                ),
                const SizedBox(height: 20),
              ],

              // Role Selector Segmented Switcher (Shown in Sign In or Step 1)
              if (!_isSignUp || _signUpStep == 1) ...[
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      _buildRoleChip(
                        role: UserRole.traveler,
                        label: 'Traveler',
                        icon: Icons.hiking_rounded,
                        activeColor: const Color(0xFF16A34A),
                      ),
                      _buildRoleChip(
                        role: UserRole.business,
                        label: 'Business',
                        icon: Icons.storefront_rounded,
                        activeColor: const Color(0xFF2563EB),
                      ),
                      _buildRoleChip(
                        role: UserRole.admin,
                        label: 'Admin',
                        icon: Icons.admin_panel_settings_rounded,
                        activeColor: const Color(0xFF9333EA),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],

              // Form Views
              if (_isSignUp) ...[
                // STEP 1: Details
                if (_signUpStep == 1) ...[
                  if (_selectedRole == UserRole.business) ...[
                    _buildTextField(
                      controller: _businessNameCtrl,
                      label: 'Business / Company Name *',
                      hint: 'Himalayan Sherpa Expeditions Pvt. Ltd.',
                      icon: Icons.business_rounded,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 14),
                  ],

                  if (_selectedRole == UserRole.admin) ...[
                    _buildTextField(
                      controller: _adminBadgeCtrl,
                      label: 'NTB Officer Badge / Gov ID Number *',
                      hint: 'NTB-OFFICER-9981',
                      icon: Icons.badge_outlined,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 14),
                  ],

                  _buildTextField(
                    controller: _nameCtrl,
                    label: _selectedRole == UserRole.business
                        ? 'Proprietor / Manager Name *'
                        : (_selectedRole == UserRole.admin ? 'Officer Full Name *' : 'Full Name *'),
                    hint: _selectedRole == UserRole.admin ? 'Kritish Shrestha' : 'Aayush Pradhan',
                    icon: Icons.person_outline_rounded,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),

                  if (_selectedRole != UserRole.admin) ...[
                    _buildTextField(
                      controller: _emailCtrl,
                      label: 'Email Address *',
                      hint: 'name@visitnepal.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 14),
                  ],

                  _buildTextField(
                    controller: _phoneCtrl,
                    label: 'Contact Phone Number *',
                    hint: '+977 9812345678',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),

                  _buildTextField(
                    controller: _passwordCtrl,
                    label: 'Password *',
                    hint: '••••••••',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                    onChanged: (_) => setState(() {}),
                    isDark: isDark,
                  ),

                  // Live Password Checklist
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Password Checklist:',
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildCheckItem('At least 8 characters', hasMinLength, isDark),
                        const SizedBox(height: 4),
                        _buildCheckItem('1 Uppercase letter (A-Z)', hasUppercase, isDark),
                        const SizedBox(height: 4),
                        _buildCheckItem('1 Lowercase letter (a-z)', hasLowercase, isDark),
                        const SizedBox(height: 4),
                        _buildCheckItem('1 Numeric digit (0-9)', hasDigit, isDark),
                        const SizedBox(height: 4),
                        _buildCheckItem('1 Special symbol (@, #, \$, !)', hasSymbol, isDark),
                      ],
                    ),
                  ),
                ],

                // STEP 2: OTP Verification
                if (_signUpStep == 2) ...[
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0552A2).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF0552A2).withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.mark_email_read_rounded, color: Color(0xFF0552A2), size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Verification Code Sent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text(
                                'Check ${_emailCtrl.text.isEmpty ? _phoneCtrl.text : _emailCtrl.text} for 6-digit code',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text('Enter 6-Digit Code:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : const Color(0xFF334155))),
                  const SizedBox(height: 12),

                  // 6 Box OTP Input Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 44,
                        height: 52,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0552A2), width: 2)),
                          ),
                          onChanged: (val) {
                            if (val.isNotEmpty && index < 5) {
                              _otpFocusNodes[index + 1].requestFocus();
                            } else if (val.isEmpty && index > 0) {
                              _otpFocusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        _prefillOtpCode();
                        AppFeedback.showSuccess(context, 'New 6-digit code sent');
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: const Text('Resend Code (30s)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                    ),
                  ),
                ],

                // STEP 3: Role Documents Verification
                if (_signUpStep == 3) ...[
                  if (_selectedRole == UserRole.business) ...[
                    // Business Owner Legal Documents & Nagarikta / NID View
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2563EB).withValues(alpha: 0.25)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.gavel_rounded, color: Color(0xFF2563EB), size: 24),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nepali Business & Nagarikta / NID Verification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                SizedBox(height: 2),
                                Text('Proprietor Citizenship ID & Firm Reg required for NTB certification.', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    _buildTextField(
                      controller: _citizenshipCtrl,
                      label: 'NID (National ID) or Nagarikta Number *',
                      hint: '27-01-78-01234',
                      icon: Icons.verified_user_outlined,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _regCtrl,
                            label: 'Company Reg # *',
                            hint: 'CRO-9988221',
                            icon: Icons.badge_outlined,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                            controller: _panCtrl,
                            label: 'PAN / VAT Number *',
                            hint: 'PAN-601234567',
                            icon: Icons.assignment_outlined,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Business License Category *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? Colors.white70 : const Color(0xFF334155))),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: _businessLicenseType,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.storefront_outlined, size: 20, color: Color(0xFF64748B)),
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: isDark ? Colors.white12 : const Color(0xFFE2E8F0))),
                          ),
                          items: [
                            'Hotel & Resort License (HAN)',
                            'Trekking & Expedition Agency License (TAAN)',
                            'Aviation & Rescue Service License',
                            'Adventure & Rafting License',
                            'Tour Operator & Transport License'
                          ].map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 12)))).toList(),
                          onChanged: (val) => setState(() => _businessLicenseType = val!),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Upload Business Registration & Nagarikta / PAN Certificate Scan
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _docUploaded = !_docUploaded;
                        });
                        AppFeedback.showSuccess(context, _docUploaded ? 'Nagarikta, Registration & PAN scans uploaded!' : 'Document scan removed');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _docUploaded ? const Color(0xFF16A34A) : Colors.grey.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _docUploaded ? Icons.task_alt_rounded : Icons.cloud_upload_outlined,
                              color: _docUploaded ? const Color(0xFF16A34A) : const Color(0xFF0552A2),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _docUploaded ? 'Nagarikta & PAN Scans Uploaded ✓' : 'Upload Nagarikta, Firm Reg & PAN Scans',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: _docUploaded ? const Color(0xFF16A34A) : (isDark ? Colors.white : const Color(0xFF0F172A)),
                                    ),
                                  ),
                                  Text(
                                    _docUploaded ? 'nagarikta_and_firm_reg_scan.pdf (Verified)' : 'Tap to select PDF or image scans',
                                    style: TextStyle(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (_selectedRole == UserRole.admin) ...[
                    // Government Admin Officer ID Verification View
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9333EA).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF9333EA).withValues(alpha: 0.25)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.admin_panel_settings_rounded, color: Color(0xFF9333EA), size: 24),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NTB Government Officer Accreditation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                SizedBox(height: 2),
                                Text('Verified against Nepal Tourism Board (NTB) official registry.', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    _buildTextField(
                      controller: _adminBadgeCtrl,
                      label: 'NTB Officer Badge / Gov ID Number *',
                      hint: 'NTB-OFFICER-9981',
                      icon: Icons.badge_outlined,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _citizenshipCtrl,
                      label: 'Nepali Citizenship ID / Nagarikta Number *',
                      hint: '27-01-78-01234',
                      icon: Icons.verified_user_outlined,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 14),

                    // Upload Official Government ID Card Scan
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _docUploaded = !_docUploaded;
                        });
                        AppFeedback.showSuccess(context, _docUploaded ? 'NTB Officer ID Card scan uploaded!' : 'Document scan removed');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _docUploaded ? const Color(0xFF16A34A) : Colors.grey.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _docUploaded ? Icons.task_alt_rounded : Icons.cloud_upload_outlined,
                              color: _docUploaded ? const Color(0xFF16A34A) : const Color(0xFF9333EA),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _docUploaded ? 'NTB Officer Badge Scan Uploaded ✓' : 'Upload NTB Officer ID Card Photo',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: _docUploaded ? const Color(0xFF16A34A) : (isDark ? Colors.white : const Color(0xFF0F172A)),
                                    ),
                                  ),
                                  Text(
                                    _docUploaded ? 'ntb_officer_badge_9981.pdf (Verified)' : 'Tap to select photo scan or PDF',
                                    style: TextStyle(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    // Traveler Tourist Documents View
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.25)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.flight_land_rounded, color: Color(0xFF16A34A), size: 24),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nepal Tourist Entry Requirements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                SizedBox(height: 2),
                                Text('Required by Department of Immigration & NTB for trek permits.', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _nationalityCtrl,
                            label: 'Country / Nationality *',
                            hint: 'United States',
                            icon: Icons.flag_outlined,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                            controller: _passportCtrl,
                            label: 'Passport Number *',
                            hint: 'US-99882211',
                            icon: Icons.badge_outlined,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tourist Visa Type *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? Colors.white70 : const Color(0xFF334155))),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: _visaType,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.assignment_ind_outlined, size: 20, color: Color(0xFF64748B)),
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: isDark ? Colors.white12 : const Color(0xFFE2E8F0))),
                          ),
                          items: [
                            'On-Arrival Tourist Visa (30 Days)',
                            'On-Arrival Tourist Visa (90 Days)',
                            'Pre-Issued Tourist Visa',
                            'Indian National (No Visa Needed)',
                            'Diplomatic / Official Visa'
                          ].map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 12)))).toList(),
                          onChanged: (val) => setState(() => _visaType = val!),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildTextField(
                            controller: _emergencyCtrl,
                            label: 'Emergency Contact *',
                            hint: 'John Smith (+1 415 555 0199)',
                            icon: Icons.contact_phone_outlined,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: _buildTextField(
                            controller: _bloodCtrl,
                            label: 'Blood Group',
                            hint: 'O+',
                            icon: Icons.bloodtype_outlined,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Upload Passport Scan Button Card
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _docUploaded = !_docUploaded;
                        });
                        AppFeedback.showSuccess(context, _docUploaded ? 'Passport photo scan uploaded!' : 'Scan removed');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _docUploaded ? const Color(0xFF16A34A) : Colors.grey.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _docUploaded ? Icons.task_alt_rounded : Icons.cloud_upload_outlined,
                              color: _docUploaded ? const Color(0xFF16A34A) : const Color(0xFF0552A2),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _docUploaded ? 'Passport Scan Uploaded ✓' : 'Upload Passport Bio-Page Photo',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: _docUploaded ? const Color(0xFF16A34A) : (isDark ? Colors.white : const Color(0xFF0F172A)),
                                    ),
                                  ),
                                  Text(
                                    _docUploaded ? 'US-99882211_passport_scan.jpg (Verified)' : 'Tap to select photo scan or PDF',
                                    style: TextStyle(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],

                // STEP 4: Welcome Preferences (Traveler)
                if (_signUpStep == 4) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle),
                          child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Documents Verified & Approved!', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.5, color: isDark ? Colors.white : const Color(0xFF0F172A))),
                              const SizedBox(height: 2),
                              const Text('Select what you love to explore in Nepal:', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Interest Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _interestsOptions.map((item) {
                      final String label = item['label'];
                      final IconData icon = item['icon'];
                      final isSelected = _selectedInterests.contains(label);

                      return FilterChip(
                        selected: isSelected,
                        showCheckmark: false,
                        avatar: Icon(icon, size: 16, color: isSelected ? Colors.white : const Color(0xFF0552A2)),
                        label: Text(label),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF334155)),
                        ),
                        selectedColor: const Color(0xFF0552A2),
                        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedInterests.add(label);
                            } else {
                              _selectedInterests.remove(label);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ] else ...[
                // Sign In Form
                if (_selectedRole == UserRole.business) ...[
                  _buildTextField(
                    controller: _businessNameCtrl,
                    label: 'Business / Agency Name',
                    hint: 'Himalayan Sherpa Expeditions',
                    icon: Icons.business_rounded,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                ],

                if (_selectedRole == UserRole.admin) ...[
                  _buildTextField(
                    controller: _adminBadgeCtrl,
                    label: 'NTB Government Officer Badge / Gov ID Number *',
                    hint: 'NTB-OFFICER-9981',
                    icon: Icons.badge_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                ] else ...[
                  _buildTextField(
                    controller: _emailCtrl,
                    label: 'Email Address *',
                    hint: 'name@visitnepal.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                ],

                _buildTextField(
                  controller: _passwordCtrl,
                  label: 'Password *',
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                  isDark: isDark,
                ),

                const SizedBox(height: 12),

                // Remember Me & Forgot Password Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: const Color(0xFF0552A2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            onChanged: (val) => setState(() => _rememberMe = val ?? true),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => _rememberMe = !_rememberMe),
                          child: Text(
                            'Remember me',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _showForgotPasswordDialog,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 24),

              // Action Button
              AppButton(
                text: _isSignUp
                    ? (_signUpStep == 1
                        ? 'Continue to Verification →'
                        : (_signUpStep == 2
                            ? 'Verify Email & Phone →'
                            : (_signUpStep == 3
                                ? (_selectedRole == UserRole.business
                                    ? 'Verify Business & Nagarikta →'
                                    : (_selectedRole == UserRole.admin ? 'Verify NTB Officer Gov ID →' : 'Save Travel Documents →'))
                                : 'Start Exploring Nepal 🚀')))
                    : 'Sign In as ${_getRoleTitle()}',
                onPressed: _handleAuthenticate,
                width: double.infinity,
                height: 52,
              ),

              const SizedBox(height: 16),

              // Sign In / Sign Up Switcher
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isSignUp ? 'Already have an account? ' : "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white60 : const Color(0xFF64748B),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSignUp = !_isSignUp;
                          _signUpStep = 1;
                        });
                      },
                      child: Text(
                        _isSignUp ? 'Sign In' : 'Sign Up',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepBar({
    required int stepNum,
    required String label,
    required int activeStep,
    required bool isDark,
  }) {
    final bool isCompleted = activeStep > stepNum;
    final bool isCurrent = activeStep == stepNum;
    final Color barColor = isCompleted || isCurrent ? const Color(0xFF16A34A) : (isDark ? Colors.white24 : const Color(0xFFE2E8F0));

    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCompleted)
                const Icon(Icons.check_circle_rounded, size: 10, color: Color(0xFF16A34A))
              else
                Text('$stepNum. ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isCurrent ? const Color(0xFF16A34A) : Colors.grey)),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                  color: isCurrent ? (isDark ? Colors.white : const Color(0xFF0F172A)) : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text, bool isMet, bool isDark) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
          size: 15,
          color: isMet ? const Color(0xFF16A34A) : (isDark ? Colors.white38 : const Color(0xFF94A3B8)),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isMet ? FontWeight.w700 : FontWeight.w500,
            color: isMet
                ? const Color(0xFF16A34A)
                : (isDark ? Colors.white60 : const Color(0xFF64748B)),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleChip({
    required UserRole role,
    required String label,
    required IconData icon,
    required Color activeColor,
  }) {
    final isSelected = _selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedRole = role;
            _fillDefaultCredentials();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
    ValueChanged<String>? onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white70 : const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword && obscureText,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
            ),
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF64748B)),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      size: 20,
                      color: const Color(0xFF64748B),
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getRoleTitle() {
    switch (_selectedRole) {
      case UserRole.traveler:
        return 'Traveler';
      case UserRole.business:
        return 'Business Partner';
      case UserRole.admin:
        return 'Government Admin';
    }
  }
}
