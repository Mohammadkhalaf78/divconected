import 'package:dev_connected/core/constance/widgets/app_logo.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/all_job_screen.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/applied_jobs_screen.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/jobs_page/saved_jobs.dart';
import 'package:dev_connected/features/Jobs/presntation/screens/tap_items.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          JobBloc(sl(), sl(), sl(), sl())..add(GetJobRequested()),

      child: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {},

        builder: (context, state) {
          return DefaultTabController(
            length: 3,

            child: Scaffold(
              backgroundColor: ColorsManager.white,

              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: ColorsManager.white,

                      pinned: true,

                      expandedHeight: 160,

                      title: const AppLogo(),

                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none),
                        ),
                      ],
                      // flexibleSpace: FlexibleSpaceBar(
                      //   background: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 110,
                      //       left: 16,
                      //       right: 16,
                      //     ),

                      //     child: AppTextFormFiled(
                      //       controller: TextEditingController(),

                      //       hintText: 'Search jobs',

                      //       onChanged: (value) {
                      //         // هنا هنضيف search logic بعدين
                      //       },
                      //     ),
                      //   ),
                      // ),

                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(45),

                        child: Container(
                          height: 60,

                          margin: const EdgeInsets.symmetric(horizontal: 20),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            color: Colors.green[100],
                          ),

                          child: TabBar(
                            padding: const EdgeInsets.all(16),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                              color: Colors.green[400],
                            ),

                            labelColor: Colors.white,

                            unselectedLabelColor: Colors.black,

                            tabs: [
                              TapItems(
                                title: 'All',

                                count: state.jobs?.length ?? 0,
                              ),

                              TapItems(
                                title: 'Saved',

                                count: state.jobs?.length ?? 0,
                              ),

                              TapItems(
                                title: 'Applied',

                                count: state.appliedJobs?.length ?? 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },

                body: TabBarView(
                  children: [
                    AllJobScreen(user: user),

                    const SavedJobsScreen(),

                    const AppliedJobsScreen(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
