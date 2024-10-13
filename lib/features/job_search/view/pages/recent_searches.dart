import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/job_search_cubit.dart';
import '../../viewmodel/job_search_state.dart';
import '../widgets/recent_searches.dart';

class RecentSearchesScreen extends StatelessWidget {
  const RecentSearchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<JobSearchCubit>().fetchRecentSearches();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Searches'),
      ),
      body: BlocBuilder<JobSearchCubit, JobSearchState>(
        builder: (context, state) {
          if (state is JobSearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JobSearchSuccess) {
            final recentSearches = context.watch<JobSearchCubit>().recentSearches;

            if (recentSearches.isEmpty) {
              return const Center(
                child: Text('No recent searches found.'),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                return RecentSearches(
                  name: recentSearches[index],
                  onDelete: () {

                    context.read<JobSearchCubit>().removeRecentSearch(recentSearches[index]);
                  },
                );
              },
            );
          } else if (state is JobSearchNoResult) {
            return const Center(
              child: Text('No recent searches found.'),
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}
