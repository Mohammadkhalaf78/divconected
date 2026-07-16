import 'package:dev_connected/core/constance/widgets/app_button_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_section_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/create_job_bloc.dart';
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
      create: (context) => CreateJobBloc(sl(),sl()),
      child: BlocConsumer<CreateJobBloc, JobsState>(
        listener: (context, state) {
          if (state.createJobState == RequestState.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.createJobMessage),
                backgroundColor: ColorsManager.green,
              ),
            );
          } else if (state.createJobState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.createJobMessage),
                backgroundColor: Colors.red,
              ),
            );
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
                        hintText: 'Job Title',
                        controller: jobTitleController,
                      ),

                      SizedBox(height: 20),

                      // job type
                      AppSelectedForm<JobType>(
                        controller: jobTypeController,
                        labelText: 'Job Type',
                        items: JobType.values,
                        itemLabel: (item) => item.name,
                        onSelected: (selected) {
                          context.read<CreateJobBloc>().add(
                            JobTypeChanged(selected),
                          );
                        },
                      ),

                      SizedBox(height: 20),

                      AppSelectedForm<Location>(
                        controller: jobLocationController,
                        labelText: 'Job Location',
                        items: Location.values,
                        itemLabel: (item) => item.name,
                        onSelected: (selected) {
                          // Handle the selected location
                          context.read<CreateJobBloc>().add(
                            LocationChanged(selected),
                          );
                        },
                      ),

                      SizedBox(height: 20),

                      AppTextFormFiled(
                        hintText: 'Salary Range ',
                        controller: salaryController,
                      ),

                      SizedBox(height: 20),

                      AppTextFormFiled(
                        hintText: 'Description',
                        controller: descriptionController,
                        minLines: 4,
                        maxLines: 6,
                      ),

                      SizedBox(height: 20),

                      AppTextFormFiled(
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
                                  context.read<CreateJobBloc>().add(
                                    CreateJobSubmitted(
                                      jobTitle: jobTitleController.text,
                                      jobType: state.jobtype,
                                      location: state.location,
                                      salaryRange: salaryController.text,
                                      description: descriptionController.text,
                                      requirements: requirementsController.text,
                                      companyName: user!.fullName,
                                      companyImage:
                                          user!.profileImage ??
                                          '', // Ensure non-null String
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
