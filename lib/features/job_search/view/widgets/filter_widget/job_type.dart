import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/mock_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

class JobTypesFilterWidget extends StatelessWidget {
  const JobTypesFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final jobTypesFilter = allFilters
        .firstWhere((filter) => filter is JobTypesFilter) as JobTypesFilter;
    return Wrap(
      spacing: 8.0,
      children: jobTypesFilter.jobTypes.map((jobTypes) {
        final isSelected = context.watch<JobSearchCubit>().isFilterSelected(jobTypes);

        return ChoiceChip(
          label: Text(jobTypes),
          selected: isSelected,
          onSelected: (selected) {            
            context.read<JobSearchCubit>().toggleFilter(jobTypes);
          },
        );
      }).toList(),
    );
  }
}
