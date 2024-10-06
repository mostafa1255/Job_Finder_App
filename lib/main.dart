import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jop_finder_app/features/job_search/view/pages/job_search.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => JobSearchCubit(),
      child: const JobFinder(),
    ),
  );
}
class JobFinder extends StatelessWidget {
  const JobFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: JobSearchScreen(),
    );
  }
}
