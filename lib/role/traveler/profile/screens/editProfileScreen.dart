import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _bioCtrl;
  late TextEditingController _nationalityCtrl;
  late TextEditingController _passportCtrl;
  late TextEditingController _emergencyCtrl;
  late TextEditingController _bloodCtrl;

  late String _avatarUrl;

  final List<String> _presetAvatars = const [
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
  ];

  @override
  void initState() {
    super.initState();
    final u = MockData.currentUser;
    _nameCtrl = TextEditingController(text: u['name'] ?? '');
    _emailCtrl = TextEditingController(text: u['email'] ?? '');
    _phoneCtrl = TextEditingController(text: u['phone'] ?? '+977 9841234567');
    _bioCtrl = TextEditingController(text: u['bio'] ?? '');
    _nationalityCtrl = TextEditingController(text: u['nationality'] ?? 'Nepali');
    _passportCtrl = TextEditingController(text: u['passportNumber'] ?? 'NPL-9988221');
    _emergencyCtrl = TextEditingController(text: u['emergencyContact'] ?? 'Pasang Sherpa (+977 9801122334)');
    _bloodCtrl = TextEditingController(text: u['bloodGroup'] ?? 'O+');
    _avatarUrl = u['avatar'] ?? _presetAvatars[0];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _bioCtrl.dispose();
    _nationalityCtrl.dispose();
    _passportCtrl.dispose();
    _emergencyCtrl.dispose();
    _bloodCtrl.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_nameCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'Name and email cannot be empty');
      return;
    }

    setState(() {
      MockData.currentUser['name'] = _nameCtrl.text.trim();
      MockData.currentUser['email'] = _emailCtrl.text.trim();
      MockData.currentUser['phone'] = _phoneCtrl.text.trim();
      MockData.currentUser['bio'] = _bioCtrl.text.trim();
      MockData.currentUser['nationality'] = _nationalityCtrl.text.trim();
      MockData.currentUser['passportNumber'] = _passportCtrl.text.trim();
      MockData.currentUser['emergencyContact'] = _emergencyCtrl.text.trim();
      MockData.currentUser['bloodGroup'] = _bloodCtrl.text.trim();
      MockData.currentUser['avatar'] = _avatarUrl;
    });

    AppFeedback.showSuccess(context, 'Profile changes saved!');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0552A2)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Change Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0552A2),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: Image.network(
                              _avatarUrl,
                              width: 84,
                              height: 84,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const CircleAvatar(
                                radius: 42,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, size: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              // Cycle through preset avatars
                              final nextIdx = (_presetAvatars.indexOf(_avatarUrl) + 1) % _presetAvatars.length;
                              setState(() => _avatarUrl = _presetAvatars[nextIdx]);
                              AppFeedback.showInfo(context, 'Avatar photo updated');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0552A2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap camera icon to change photo',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: isDark ? Colors.white54 : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section 1: Personal Details
              _buildSectionTitle('PERSONAL INFORMATION', isDark),
              const SizedBox(height: 10),

              _buildInputField(
                controller: _nameCtrl,
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 14),

              _buildInputField(
                controller: _emailCtrl,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                isDark: isDark,
              ),
              const SizedBox(height: 14),

              _buildInputField(
                controller: _phoneCtrl,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                isDark: isDark,
              ),
              const SizedBox(height: 14),

              _buildInputField(
                controller: _bioCtrl,
                label: 'Bio / Trek Motto',
                icon: Icons.edit_note_rounded,
                maxLines: 2,
                isDark: isDark,
              ),

              const SizedBox(height: 22),

              // Section 2: Identification & Travel Docs
              _buildSectionTitle('TRAVEL DOCUMENTS & CITIZENSHIP', isDark),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _nationalityCtrl,
                      label: 'Nationality',
                      icon: Icons.flag_outlined,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      controller: _passportCtrl,
                      label: 'Passport / Citizenship ID',
                      icon: Icons.badge_outlined,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Section 3: Safety & Emergency
              _buildSectionTitle('EMERGENCY & TREK SAFETY', isDark),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildInputField(
                      controller: _emergencyCtrl,
                      label: 'Emergency Contact',
                      icon: Icons.contact_phone_outlined,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: _buildInputField(
                      controller: _bloodCtrl,
                      label: 'Blood Group',
                      icon: Icons.bloodtype_outlined,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Save Button
              AppButton(
                text: 'Save Profile Changes',
                onPressed: _saveProfile,
                width: double.infinity,
                height: 52,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
        color: isDark ? Colors.white54 : const Color(0xFF64748B),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
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
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13.5),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 19, color: const Color(0xFF64748B)),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
}
