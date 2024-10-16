import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/jobs_card.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({
    super.key,
    required this.jobTitle,
    required this.jobs,
  });

  final String jobTitle;
  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobTitle),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return JobsCard(
              jobTitle: job.jobTitle ?? 'Unknown Title',
              salary: job.salary ?? 'Unknown Title',
              companyName: job.companyName ?? 'Unknown Title',
              location: job.location ?? 'Unknown Title',
              imageUrl: job.imageUrl ?? 'Unknown Title',
            );
          },
        ),
      ),
    );
  }
}
