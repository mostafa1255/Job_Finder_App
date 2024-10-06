import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/filter_widget/filter_bottom_sheet.dart';
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
        backgroundColor: Colors.transparent,
        title: Text(jobTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_sharp),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return  const FilterBottomSheet();
                  
                },
              );
            },
          ),
        ],      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return JobsCard(
            jobTitle: job.jobTitle,
            salary: job.salary,
            companyName: job.companyName,
            location: job.location,
            imageUrl: job.imageUrl,
          );
        },
      ),
    );
  }
}
