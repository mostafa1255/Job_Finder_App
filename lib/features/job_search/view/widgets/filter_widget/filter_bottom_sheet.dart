import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/companies.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/experience_level.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/job_location.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/job_type.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/roles.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/salary_range.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTabController(
            length: 6,
            child: Column(
              children: <Widget>[
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Companies'),
                    Tab(text: 'Roles'),
                    Tab(text: 'Job Types'),
                    Tab(text: 'Experience'),
                    Tab(text: 'Job Location'),
                    Tab(text: 'Salary Range'),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BlocBuilder<JobSearchCubit, JobSearchState>(
                    builder: (context, state) {
                        return const TabBarView(
                          children: [
                            CompaniesFilterWidget(),
                            RolesFilterWidget(),
                            JobTypesFilterWidget(),
                            ExperienceLevelFilterWidget(),
                            JobLocationFilterWidget(),
                            SalaryRangeFilterWidget(),
                          ],
                        );
                      
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                final selectedFilters =
                    context.read<JobSearchCubit>().selectedFilters;

                context.read<JobSearchCubit>().setFilters(selectedFilters);

                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
