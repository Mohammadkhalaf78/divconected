import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool showEmail = true;
  bool showPhone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: kTextDark),
        ),
        title: const Text(
          'Privacy & Security',
          style: TextStyle(
            color: kTextDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Center(
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: kPrimaryPurple.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shield_outlined,
                color: kPrimaryPurple,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 24),

          _SettingsRow(
            icon: Icons.visibility_outlined,
            title: 'Who can view my profile',
            subtitle: 'Everyone',
            onTap: () {
              // Handle navigation to profile visibility selection
            },
          ),
          const SizedBox(height: 12),

          _ToggleRow(
            icon: Icons.email_outlined,
            title: 'Show email to others',
            value: showEmail,
            onChanged: (value) {
              setState(() => showEmail = value);
              // Handle show email toggle
            },
          ),
          const SizedBox(height: 12),

          _ToggleRow(
            icon: Icons.phone_outlined,
            title: 'Show phone number',
            value: showPhone,
            onChanged: (value) {
              setState(() => showPhone = value);
              // Handle show phone toggle
            },
          ),
          const SizedBox(height: 12),

          _SettingsRow(
            icon: Icons.verified_user_outlined,
            title: 'Two-Factor Authentication',
            subtitle: 'Enable extra security',
            onTap: () {
              // Handle navigation to Two-Factor Authentication setup
            },
          ),
          const SizedBox(height: 12),

          _SettingsRow(
            icon: Icons.access_time,
            title: 'Active Sessions',
            subtitle: 'Manage your active sessions',
            onTap: () {
              // Handle navigation to Active Sessions screen
            },
          ),

          const SizedBox(height: 24),

          // Info banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kPrimaryPurple.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield, color: kPrimaryPurple, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'We value your privacy and work hard to protect your data.',
                    style: TextStyle(fontSize: 13, color: kTextDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsManager.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryPurple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: kPrimaryPurple, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: kTextGray),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: kTextGray),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryPurple.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: kPrimaryPurple, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kTextDark,
              ),
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: kPrimaryPurple,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
