import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);
const Color kWarningAmber = Color(0xFFF59E0B);
const Color kDangerRed = Color(0xFFEF4444);

class AccountSettingsScreen extends StatefulWidget {
const  AccountSettingsScreen({super.key});
  
  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool isDarkMode = false;

  

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
          'Account Settings',
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
          _SettingsRow(
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            subtitle: 'Update your personal info',
            onTap: () {
              // Handle navigation to Edit Profile screen

            
            },
          ),
          const SizedBox(height: 12),
          _SettingsRow(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {
              // Handle navigation to Change Password screen
            },
          ),
          const SizedBox(height: 12),
          _SettingsRow(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English', 
            onTap: () {
              // Handle navigation to Language selection screen
            },
          ),
          const SizedBox(height: 12),
          _SettingsRow(
            icon: Icons.notifications_outlined,
            title: 'Notification Preferences',
            subtitle: 'Manage your notifications',
            onTap: () {
              // Handle navigation to Notification Preferences screen
            },
          ),
          const SizedBox(height: 12),

          // Dark Mode toggle
          Container(
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
                  child: const Icon(
                    Icons.dark_mode_outlined,
                    color: kPrimaryPurple,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kTextDark,
                    ),
                  ),
                ),
                Switch(
                  value: isDarkMode,
                  activeThumbColor: kPrimaryPurple,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    // Handle dark mode toggle (persist preference / update theme)
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Danger zone
          _SettingsRow(
            icon: Icons.pause_circle_outline,
            iconColor: kWarningAmber,
            title: 'Deactivate Account',
            titleColor: kWarningAmber,
            subtitle: 'Temporarily disable your account',
            onTap: () {
              // Handle navigation to Deactivate Account flow
            },
          ),
          const SizedBox(height: 12),
          _SettingsRow(
            icon: Icons.delete_outline,
            iconColor: kDangerRed,
            title: 'Delete Account',
            titleColor: kDangerRed,
            subtitle: 'Permanently delete your account',
            onTap: () {
              // Handle navigation to Delete Account confirmation screen
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    this.iconColor = kPrimaryPurple,
    required this.title,
    this.titleColor = kTextDark,
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
                color: Colors.black.withValues(alpha: 0.01),
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
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: kTextGray),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: kTextGray),
            ],
          ),
        ),
      ),
    );
  }
}
