import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/job_datails_screen.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/widgets/job_card.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllJobScreen extends StatelessWidget {
  const AllJobScreen({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobBloc, JobState>(
      listener: (context, state) {},
      builder: (context, state) {
        final jobBloc = context.read<JobBloc>();

        return Column(
          children: [
        

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<JobBloc>().add(GetJobRequested());
                },
                child: state.jobs != null
                    ? ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: state.jobs!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: jobBloc,

                                    child: JobDatailsScreen(
                                      job: state.jobs![index],
                                      currentUser: user!,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: JobCard(job: state.jobs![index]),
                          );
                        },
                      )
                    // Wrap the empty state in a scrollable too, or
                    // RefreshIndicator has nothing to attach the pull gesture to.
                    : ListView(
                        children: const [
                          SizedBox(height: 100),
                          Center(child: Text('No jobs available')),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
