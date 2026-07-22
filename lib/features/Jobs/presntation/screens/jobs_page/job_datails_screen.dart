import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_apply_button.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_description_section.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_details_app_bar.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_header_section.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_meta_section.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_requirements_section.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_salary_section.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_skills_section.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDatailsScreen extends StatelessWidget {
  const JobDatailsScreen({
    super.key,
    required this.job,
    required this.currentUser,
  });

  final JobEntity job;
  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobBloc, JobsState>(
      listener: (context, state) {
        if (state.applyJobState == RequestState.loaded) {
          AppTopSnackBar.success(
            context,
            message: 'Applied to job successfully!',
          );
          Navigator.pop(
            context,
          ); // Close the job details screen after successful application
        } else if (state.applyJobState == RequestState.error) {
          AppTopSnackBar.error(context, message: state.applyJobMessage);
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        body: SafeArea(
          child: Column(
            children: [
              const JobDetailsAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      JobHeaderSection(job: job),
                      const SizedBox(height: 16),
                      JobMetaSection(job: job),
                      const Divider(height: 32),
                      JobSalarySection(salaryRange: job.salaryRange),
                      const SizedBox(height: 24),
                      JobDescriptionSection(description: job.description),
                      const SizedBox(height: 24),
                      JobRequirementsSection(requirements: job.requirements),
                      const SizedBox(height: 24),
                      // JobEntity has no `skills` field yet, so this is empty
                      // for now. Add a `skills` list to JobEntity to populate
                      // this section (see notes at the end of the chat message).
                      const JobSkillsSection(skills: []),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: JobApplyButton(
                  onPressed: () {
                    context.read<JobBloc>().add(
                      ApplyJobRequested(
                        jobId: job.id ?? '',
                        userId: currentUser.id, //
                        companyId: job.companyId ?? '',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
