import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppliedJobsScreen extends StatefulWidget {
  const AppliedJobsScreen({super.key});

  @override
  State<AppliedJobsScreen> createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends State<AppliedJobsScreen> {
  @override
  void initState() {
    context.read<JobBloc>().add(GetAppliedJobsRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state.getApplyJobState == RequestState.error) {
          AppTopSnackBar.error(context, message: state.getApplyJobMessage);
        }
      },
      child: Scaffold(
        body: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if (state.getApplyJobState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.getApplyJobState == RequestState.loaded) {
              final appliedJobs = state.appliedJobs;
              if (appliedJobs!.isEmpty) {
                return const Center(child: Text('No applied jobs found.'));
              }
              return ListView.builder(
                itemCount: appliedJobs.length,
                itemBuilder: (context, index) {
                  final job = appliedJobs[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(job.companyImage),
                      ),
                      title: Text(job.jobTitle),
                      subtitle: Text(job.companyName),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: job.status == ApplicationStatus.accepted
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(job.status.name),
                      ),
                    ),
                  );
                },
              );
            } else if (state.getApplyJobState == RequestState.error) {
              return Center(child: Text(state.getApplyJobMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
