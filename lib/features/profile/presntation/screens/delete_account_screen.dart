import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);
const Color kDangerRed = Color(0xFFEF4444);

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

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
          'Delete Account',
          style: TextStyle(
            color: kTextDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: kDangerRed.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: kDangerRed,
                size: 44,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Delete your account?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This action cannot be undone. All your data will be permanently removed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: kTextGray),
            ),

            const SizedBox(height: 24),

            // Warning box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kDangerRed.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'This will delete:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kDangerRed,
                    ),
                  ),
                  SizedBox(height: 8),
                  _BulletText('Your profile and personal data'),
                  SizedBox(height: 4),
                  _BulletText('Your applications and jobs'),
                  SizedBox(height: 4),
                  _BulletText('Your messages and connections'),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Handle delete account button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDangerRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: ColorsManager.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  // Handle cancel button press
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: kTextDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ', style: TextStyle(color: kDangerRed, fontSize: 14)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: kDangerRed),
          ),
        ),
      ],
    );
  }
}
