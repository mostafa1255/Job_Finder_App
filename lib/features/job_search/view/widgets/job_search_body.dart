import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/view/pages/job_list.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/filter_bottom_sheet.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/recent_searches.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/search_filter.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

import '../../viewmodel/job_search_cubit.dart';

class JobSearchBody extends StatelessWidget {
  const JobSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
            ),
            const SizedBox(height: 10),
            BlocBuilder<JobSearchCubit, JobSearchState>(
              builder: (context, state) {
                if (state is JobSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JobSearchSuccess) {
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.uniqueJobTitles.length,
                        itemBuilder: (context, index) {
                          return IconButton(
                            onPressed: () {
                              final selectedJobTitle =
                                  state.uniqueJobTitles[index];
                              final filteredJobs = state.jobs
                                  .where(
                                      (job) => job.jobTitle == selectedJobTitle)
                                  .toList();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return JobListScreen(
                                      jobTitle: selectedJobTitle??'',
                                      jobs: filteredJobs,
                                    );
                                  },
                                ),
                              );
                              print(state.jobs);
                            },
                            icon: Text(state.uniqueJobTitles[index]??''),
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is JobSearchNoResult) {
                  return const Center(
                    child: Text('No jobs found'),
                  );
                } else if (state is JobSearchError) {
                  return Text(state.message);
                }
                return const Column(
                  children: [
                    Center(
                      child: Text(
                        'Search for jobs',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
