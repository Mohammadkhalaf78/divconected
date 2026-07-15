import 'package:dev_connected/core/constance/widgets/app_section_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/features/create_job/domain/entites/enums.dart';
import 'package:dev_connected/features/create_job/presntation/controller/bloc/create_job_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateJobScreen extends StatelessWidget {
  CreateJobScreen({super.key});
  final TextEditingController jobTitleController = TextEditingController();

  final TextEditingController jobTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateJobBloc(),
      child: BlocConsumer<CreateJobBloc, CreateJobState>(
        listener: (context, state) {},
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
                    controller: jobTypeController,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
