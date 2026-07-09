import 'package:flutter/material.dart';

class ProfileImageBottomSheet {
  ProfileImageBottomSheet._();

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onCameraTap,
    VoidCallback? onGalleryTap,
    VoidCallback? onRemoveTap,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      enableDrag: true,
      isDismissible: true,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: .38,
          minChildSize: .30,
          maxChildSize: .55,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                children: [
                  const SizedBox(height: 8),

                  const Text(
                    "Profile Photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  _Tile(
                    icon: Icons.camera_alt_rounded,
                    title: "Take Photo",
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.pop(context);
                      onCameraTap?.call();
                    },
                  ),

                  _Tile(
                    icon: Icons.photo_library_rounded,
                    title: "Choose From Gallery",
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);
                      onGalleryTap?.call();
                    },
                  ),

                  _Tile(
                    icon: Icons.delete_outline_rounded,
                    title: "Remove Photo",
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      onRemoveTap?.call();
                    },
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: color.withValues(alpha: .1),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}