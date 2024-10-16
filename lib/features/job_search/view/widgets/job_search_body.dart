import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/filter_bottom_sheet.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/search_filter.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/user_card.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

import '../../viewmodel/job_search_cubit.dart';
import 'job_list_section.dart';

class JobSearchBody extends StatelessWidget {
  const JobSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchFilterWidget(
              searchController: TextEditingController(),
              onClickFilter: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const FilterBottomSheet();
                  },
                );
              },
              onChangedTextField: (val) {
                context.read<JobSearchCubit>().searchJob(val);
              },
              onFieldSubmitted: (value) async {
                await context.read<JobSearchCubit>().searchJob(value);
                await context.read<JobSearchCubit>().addRecentSearch(value);
                final state = context.read<JobSearchCubit>().state;

                if (state is JobSearchSuccess) {
                  GoRouter.of(context).push(
                    '/jobList',
                    extra: {
                      'jobTitle': state.jobs.first.jobTitle ?? 'No Title',
                      'jobs': state.jobs,
                    },
                  );
                } else if (state is JobSearchNoResult) {}
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<JobSearchCubit, JobSearchState>(
              builder: (context, state) {
                if (state is JobSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JobSearchSuccess) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          (state.users.isNotEmpty)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Users',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        GoRouter.of(context).push(
                                          '/userList',
                                          extra: {
                                            'userName': '',
                                            // state.users[index]!.name ?? '',
                                            'users': state.users,
                                          },
                                        );
                                      },
                                      child: const Text('see all'),
                                    )
                                  ],
                                )
                              : const SizedBox.shrink(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              return UserCard(
                                userName: state.users[index]?.name ?? '',
                                profileImageUrl:
                                    state.users[index]?.profileImageUrl ?? '',
                                onClick: () {
                                  GoRouter.of(context).push("/othersProfileScreen",
                                    extra:
                                      {
                                        'user': state.users,
                                        'index': index,
                                      },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      JobListSection(
                        title: 'Job Titles',
                        items: state.uniqueTitles,
                        onTapItem: (jobTitle, index) {
                          GoRouter.of(context).push(
                            '/jobList',
                            extra: {
                              'jobTitle': jobTitle,
                              'jobs': state.jobs,
                            },
                          );
                        },
                      ),
                      JobListSection(
                        title: 'Company Names',
                        items: state.uniqueCompanyNames,
                        onTapItem: (companyName, index) {
                          GoRouter.of(context).push(
                            '/jobList',
                            extra: {
                              'jobTitle': companyName,
                              'jobs': state.companyNames,
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is JobSearchNoResult) {
                  return const Center(child: Text('No search found'));
                } else if (state is JobSearchError) {
                  return Text(state.message);
                }
                return Center(
                  child: Text(
                    'Search result',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
