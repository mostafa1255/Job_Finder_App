import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/mock_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

class CompaniesFilterWidget extends StatelessWidget {

  const CompaniesFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final companiesFilter = allFilters.firstWhere((filter) => filter is CompaniesFilter) as CompaniesFilter;

    return Wrap(
      spacing: 8.0,
      children: companiesFilter.companies.map((company) {
        final isSelected = context.watch<JobSearchCubit>().isFilterSelected(company);

        return ChoiceChip(
          label: Text(company),
          selected: isSelected,
          onSelected: (selected) {        
            context.read<JobSearchCubit>().toggleFilter(company);
          },
        );
      }).toList(),
    );
  }
}

