import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.isSelcted,
    required this.role,
    required this.icon,
    required this.description,
    this.onTap,
  });

  final bool isSelcted;
  final UserRole role;
  final Icon icon;
  final String description;
  final VoidCallback? onTap;

  // Set this to the desired role

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent, // أو Colors.white
          borderRadius: BorderRadius.circular(16),
          border: isSelcted
              ? Border.all(color: ColorsManager.primary, width: 2)
              : Border.all(color: ColorsManager.grey, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelcted ? ColorsManager.primary : ColorsManager.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: icon,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        role.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: isSelcted
                              ? ColorsManager.primary
                              : ColorsManager.grey,
                        ),
                      ),

                      isSelcted
                          ? Icon(
                              Icons.check_circle,
                              color: ColorsManager.primary,
                              size: 24,
                            )
                          : SizedBox(width: 24),
                    ],
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 18, color: ColorsManager.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
