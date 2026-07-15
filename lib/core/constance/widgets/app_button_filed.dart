import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalpadding,
    this.verticalPadding,
    this.buttonWidh,
    this.buttonHeight,
    required this.onPressed,
    required this.buttonText,
  });
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalpadding;
  final double? verticalPadding;
  final double? buttonWidh;
  final double? buttonHeight;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 16),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(ColorsManager.primary),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: horizontalpadding ?? 12,
            vertical: verticalPadding ?? 14,
          ),
        ),
        fixedSize: WidgetStatePropertyAll(
          Size(buttonWidh ?? double.maxFinite, buttonHeight ?? 55),
        ),
      ),

      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: ColorsManager.white, fontSize: 16),
      ),
    );
  }
}
