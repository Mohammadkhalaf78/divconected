import 'package:dev_connected/core/constance/colors_manager.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kDangerRed = Color(0xFFEF4444);

/// Call this helper to show the "Select Photo" bottom sheet
/// on top of any screen, e.g. from the "Change Photo" button
/// in EditProfileScreen:
///
/// ```dart
/// onPressed: () => showImagePickerBottomSheet(context),
/// ```
Future<void> showImagePickerBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const ImagePickerBottomSheet(),
  );
}

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Select Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextDark,
            ),
          ),
          const SizedBox(height: 16),

          _OptionRow(
            icon: Icons.camera_alt_outlined,
            label: 'Camera',
            onTap: () {
              // Handle open camera
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
          _OptionRow(
            icon: Icons.photo_library_outlined,
            label: 'Photo Library',
            onTap: () {
              // Handle open photo library
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
          _OptionRow(
            icon: Icons.delete_outline,
            iconColor: kDangerRed,
            label: 'Remove Photo',
            labelColor: kDangerRed,
            onTap: () {
              // Handle remove current photo
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 16),

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

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color labelColor;
  final VoidCallback onTap;

  const _OptionRow({
    required this.icon,
    this.iconColor = kPrimaryPurple,
    required this.label,
    this.labelColor = kTextDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
