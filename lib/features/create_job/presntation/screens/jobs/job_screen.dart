import 'package:dev_connected/core/constance/widgets/app_logo.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/features/create_job/presntation/screens/jobs/widgets/job_card.dart';
import 'package:flutter/material.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(title: AppLogo()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return JobCard();
          },
        ),
      ),
    );
  }
}
