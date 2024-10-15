import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/job_search_body.dart';
import '../../viewmodel/job_search_cubit.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.recentSearches);
              },
              icon: const Icon(Icons.history),
            ),
          ],
        ),
        body: const JobSearchBody(),
    );

  }
}
