import 'package:dev_connected/core/constance/widgets/app_logo.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/job_datails_screen.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_card.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          JobBloc(sl(), sl(), sl(), sl())..add(GetJobRequested()),
      child: BlocConsumer<JobBloc, JobState>(
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
                context.read<JobBloc>().add(GetJobRequested());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: state.jobs != null
                    ? ListView.builder(
                        itemCount: state.jobs!.length,
                        itemBuilder: (context, index) {
                          final job = state.jobs![index];
                          return InkWell(
                            onTap: () {
                              // CHANGED: pass the tapped job into
                              // JobDatailsScreen, which now requires it.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDatailsScreen(
                                    job: job,
                                    currentUser: user,
                                  ),
                                ),
                              );
                            },
                            child: JobCard(job: job),
                          );
                        },
                      )
                    : const Center(child: Text('No jobs available')),
              ),
            ),
          );
        },
      ),
    );
  }
}
