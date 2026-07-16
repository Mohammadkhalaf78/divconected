import 'package:dev_connected/core/constance/widgets/app_logo.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/create_job_bloc.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateJobBloc(sl(), sl())..add(GetJobRequested()),
      child: BlocConsumer<CreateJobBloc, JobsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorsManager.white,
            appBar: AppBar(
              backgroundColor: ColorsManager.white,

              title: AppLogo(),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.co2_outlined),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<CreateJobBloc>().add(GetJobRequested());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: state.jobs != null
                    ? ListView.builder(
                        itemCount: state.jobs!.length,
                        itemBuilder: (context, index) {
                          return JobCard(job: state.jobs![index]);
                        },
                      )
                    : Center(child: Text('No jobs available')),
              ),
            ),
          );
        },
      ),
    );
  }
}
