import 'package:dev_connected/core/constance/colors_manager.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          'Help & Support',
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
                color: kPrimaryPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: kPrimaryPurple,
                size: 36,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'How can we help you?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kTextDark,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'We\'re here to help! Reach out to us for any questions or support.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: kTextGray),
            ),
          ),

          const SizedBox(height: 24),

          _HelpRow(
            icon: Icons.help_outline,
            title: 'FAQ',
            subtitle: 'Find answers to common questions',
            onTap: () {
              // Handle navigation to FAQ screen
            },
          ),
          const SizedBox(height: 12),
          _HelpRow(
            icon: Icons.support_agent_outlined,
            title: 'Contact Support',
            subtitle: 'We\'ll get back to you',
            onTap: () {
              // Handle navigation to Contact Support screen
            },
          ),
          const SizedBox(height: 12),
          _HelpRow(
            icon: Icons.report_gmailerrorred_outlined,
            title: 'Report a Problem',
            subtitle: 'Let us know what\'s wrong',
            onTap: () {
              // Handle navigation to Report a Problem screen
            },
          ),
          const SizedBox(height: 12),
          _HelpRow(
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            onTap: () {
              // Handle navigation to Terms & Conditions screen
            },
          ),
          const SizedBox(height: 12),
          _HelpRow(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              // Handle navigation to Privacy Policy screen
            },
          ),
        ],
      ),
    );
  }
}

class _HelpRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _HelpRow({
    required this.icon,
    required this.title,
    this.subtitle,
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
                color: Colors.black.withOpacity(0.04),
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
                  color: kPrimaryPurple.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: kPrimaryPurple, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kTextDark,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(fontSize: 12, color: kTextGray),
                      ),
                    ],
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
