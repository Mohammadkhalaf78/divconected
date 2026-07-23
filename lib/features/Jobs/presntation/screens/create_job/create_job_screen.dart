import 'package:dev_connected/core/constance/widgets/app_button_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_section_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateJobScreen extends StatelessWidget {
  CreateJobScreen({super.key, required this.user});
  final UserEntity? user;
  final TextEditingController jobTitleController = TextEditingController();

  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController requirementsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobBloc(sl(), sl(), sl(),sl()),
      child: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state.createJobState == RequestState.loaded) {
            AppTopSnackBar.success(
              context,
              message: 'Job created successfully!',
            );

            // Clear the form fields after successful job creation
            jobTitleController.clear();
            jobTypeController.clear();
            jobLocationController.clear();
            salaryController.clear();
            descriptionController.clear();
            requirementsController.clear();
          } else if (state.createJobState == RequestState.error) {
            AppTopSnackBar.error(context, message: state.getJobsMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Create New Job',
                style: TextStyle(
                  color: ColorsManager.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextFormFiled(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job title';
                          }
                          return null;
                        },
                        hintText: 'Job Title',
                        controller: jobTitleController,
                      ),

                      SizedBox(height: 20),

                      // job type
                      AppSelectedForm<JobType>(
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a job type';
                          }
                          return null;
                        },
                        controller: jobTypeController,
                        labelText: 'Job Type',
                        items: JobType.values,
                        itemLabel: (item) => item.name,
                        onSelected: (selected) {
                          context.read<JobBloc>().add(JobTypeChanged(selected));
                        },
                      ),

                      SizedBox(height: 20),

                      AppSelectedForm<Location>(
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a location';
                          }
                          return null;
                        },
                        controller: jobLocationController,
                        labelText: 'Job Location',
                        items: Location.values,
                        itemLabel: (item) => item.name,
                        onSelected: (selected) {
                          // Handle the selected location
                          context.read<JobBloc>().add(
                            LocationChanged(selected),
                          );
                        },
                      ),

                      SizedBox(height: 20),

                      AppTextFormFiled(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a salary range';
                          }
                          return null;
                        },
                        hintText: 'Salary Range (e.g., \$50,000 - \$70,000)',
                        controller: salaryController,
                      ),

                      SizedBox(height: 20),

                      AppTextFormFiled(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job description';
                          }
                          return null;
                        },
                        hintText: 'Description',
                        controller: descriptionController,
                        minLines: 4,
                        maxLines: 6,
                      ),

                      SizedBox(height: 20),

                      AppTextFormFiled(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter job requirements';
                          }
                          return null;
                        },
                        hintText: 'Requirements',
                        controller: requirementsController,
                        minLines: 4,
                        maxLines: 6,
                      ),

                      SizedBox(height: 50),

                      state.createJobState == RequestState.loading
                          ? CircularProgressIndicator(
                              color: ColorsManager.primary,
                            )
                          : AppTextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<JobBloc>().add(
                                    CreateJobSubmitted(
                                      jobTitle: jobTitleController.text,
                                      jobType: state.jobtype,
                                      location: state.location,
                                      salaryRange: salaryController.text,
                                      description: descriptionController.text,
                                      requirements: requirementsController.text,
                                      companyName: user!.fullName,
                                      companyId: user!.id,
                                      companyImage:
                                          user!.imageUrl ??
                                          'https://static.vecteezy.com/system/resources/previews/046/025/400/non_2x/business-center-building-isolated-on-transparent-background-free-png.png', // Ensure non-null String
                                    ),
                                  );
                                }
                              },
                              buttonText: 'Create Job',
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
