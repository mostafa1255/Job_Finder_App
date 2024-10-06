import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/job_search_body.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Search'),
      ),
      body: const JobSearchBody(),
    );
  }
}
