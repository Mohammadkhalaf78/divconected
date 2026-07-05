import 'package:dev_connected/core/constance/colors_manager.dart';
import 'package:flutter/material.dart';

class AppTextFormFiled extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Color? backGrgroundColor;
  final Widget? suffixIcons;
  final TextEditingController? controller;
  const AppTextFormFiled({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcons, this.backGrgroundColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        hintStyle:hintStyle?? TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        hintText: hintText,
        suffixIcon: suffixIcons,

        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.primary, width: 1.3),
              borderRadius: BorderRadius.circular(16),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.grey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
        filled: true,
        fillColor:backGrgroundColor?? ColorsManager.white,
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle?? TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      )
    );
  }
}
