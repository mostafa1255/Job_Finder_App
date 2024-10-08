import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/mock_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

class RolesFilterWidget extends StatelessWidget {
  const RolesFilterWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final rolesFilter =
        allFilters.firstWhere((filter) => filter is RolesFilter) as RolesFilter;
    return Wrap(
      spacing: 8.0,
      children: rolesFilter.roles.map((roles) {
        final isSelected =
            context.watch<JobSearchCubit>().isFilterSelected(roles);

        return ChoiceChip(
          label: Text(roles),
          selected: isSelected,
          onSelected: (selected) {
            context.read<JobSearchCubit>().toggleFilter(roles);
          },
        );
      }).toList(),
    );
  }
}
