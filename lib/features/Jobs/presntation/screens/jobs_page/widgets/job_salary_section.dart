import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

/// "Salary" label + the light-purple pill badge with the salary range.
class JobSalarySection extends StatelessWidget {
  const JobSalarySection({super.key, required this.salaryRange});

  final String salaryRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Salary',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: ColorsManager.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            salaryRange,
            style: TextStyle(
              color: ColorsManager.primary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
