import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/mock_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

class ExperienceLevelFilterWidget extends StatelessWidget {
  const ExperienceLevelFilterWidget({super.key, required this.isSelected,});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final experienceLevelFilter =
        allFilters.firstWhere((filter) => filter is ExperienceLevelFilter)
            as ExperienceLevelFilter;
    return Wrap(
      spacing: 8.0,
      children: experienceLevelFilter.experienceLevels.map((experienceLevel) {
        final isSelected = context.read<JobSearchCubit>().isFilterSelected(experienceLevel);

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
