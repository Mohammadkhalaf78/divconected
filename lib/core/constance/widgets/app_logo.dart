import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.code, size: 50, color: ColorsManager.primary),
        Text(
          'Dev',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black,
          ),
        ),
        Text(
          'Connected',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ColorsManager.primary,
          ),
        ),
      ],
    );
  }
}
