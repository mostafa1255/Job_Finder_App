import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/filter_bottom_sheet.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/search_filter.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';
import '../../viewmodel/job_search_cubit.dart';

class JobSearchBody extends StatelessWidget {
  const JobSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobSearchCubit(),
      child: _JobSearchContent(),
    );
  }
}

class _JobSearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchFilterWidget(
              searchController: TextEditingController(),
              onClickFilter: () => _showFilterBottomSheet(context),
              onChangedTextField: (val) =>
                  context.read<JobSearchCubit>().searchJob(val),
              onFieldSubmitted: (value) => _handleSearchSubmit(context, value),
            ),
            const SizedBox(height: 10),
            BlocBuilder<JobSearchCubit, JobSearchState>(
              builder: (context, state) => _buildSearchResults(context, state),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  Future<void> _handleSearchSubmit(BuildContext context, String value) async {
    final cubit = context.read<JobSearchCubit>();
    await cubit.searchJob(value);
    await cubit.addRecentSearch(value);
    _navigateToJobListIfSuccessful(context, cubit.state);
  }

  void _navigateToJobListIfSuccessful(
      BuildContext context, JobSearchState state) {
    if (state is JobSearchSuccess) {
      GoRouter.of(context).push(
        '/jobList',
        extra: {
          'jobTitle': state.jobs.firstOrNull?.jobTitle ?? 'No Title',
          'jobs': state.jobs,
        },
      );
    }
  }

  Widget _buildSearchResults(BuildContext context, JobSearchState state) {
    if (state is JobSearchLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is JobSearchSuccess) {
      return _buildJobTitlesList(context, state);
    } else if (state is JobSearchNoResult) {
      return const Center(child: Text('No jobs found'));
    } else if (state is JobSearchError) {
      return Center(child: Text(state.message));
    }
    return Center(
      child: Text(
        'Search result',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildJobTitlesList(BuildContext context, JobSearchSuccess state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.uniqueJobTitles.length,
      itemBuilder: (context, index) {
        final jobTitle = state.uniqueJobTitles[index] ?? 'No Title';
        return ListTile(
          title: Text(jobTitle),
          onTap: () => _handleJobTitleTap(context, jobTitle, state.jobs[index]),
        );
      },
    );
  }

  void _handleJobTitleTap(
      BuildContext context, String jobTitle, PostedJob jobs) {
    context.read<JobSearchCubit>().addRecentSearch(jobTitle);
    // final filteredJobs = jobs.where((job) => job.jobTitle == jobTitle).toList();
    GoRouter.of(context).push(
      AppRouter.jobApplyScreen,
      extra: jobs,
    );
  }
}
