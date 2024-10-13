import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/job_search_body.dart';
import '../../viewmodel/job_search_cubit.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobSearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: const JobSearchBody(),
      ),
    );
  }
}
