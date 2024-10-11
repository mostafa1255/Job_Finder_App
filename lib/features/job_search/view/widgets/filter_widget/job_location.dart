import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/mock_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

class JobLocationFilterWidget extends StatelessWidget{
  const JobLocationFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
   final jobLocationFilter = allFilters
        .firstWhere((filter) => filter is LocationsFilter) as LocationsFilter;
    return Wrap(
      spacing: 8.0,
      children: jobLocationFilter.locations.map((jobLocation) {
        final isSelected = context.watch<JobSearchCubit>().isFilterSelected(jobLocation);

        return ChoiceChip(
          label: Text(jobLocation),
          selected: isSelected,
          onSelected: (selected) {            
            context.read<JobSearchCubit>().toggleFilter(jobLocation);
          },
        );
      }).toList(),
    );
  }
  
}