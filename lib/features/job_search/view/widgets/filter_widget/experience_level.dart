import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/filter_static_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

class ExperienceLevelFilterWidget extends StatelessWidget {
  const ExperienceLevelFilterWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final experienceLevelFilter =
        allFilters.firstWhere((filter) => filter is ExperienceLevelFilter)
            as ExperienceLevelFilter;
    return Wrap(
      spacing: 8.0,
      children: experienceLevelFilter.experienceLevels.map((experienceLevel) {
        final isSelected = context.watch<JobSearchCubit>().isFilterSelected(experienceLevel);

        return ChoiceChip(
          label: Text(experienceLevel),
          selected: isSelected,
          onSelected: (selected) {            
            context.read<JobSearchCubit>().toggleFilter(experienceLevel);
          },
        );
      }).toList(),
    );
  }
}
