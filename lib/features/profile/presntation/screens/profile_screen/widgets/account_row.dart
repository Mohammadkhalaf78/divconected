import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

class AccountRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AccountRow({super.key,
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
                  color: ColorsManager.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: ColorsManager.primary, size: 18),
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
                        color: ColorsManager.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: ColorsManager.grey),
            ],
          ),
        ),
      ),
    );
  }
}
