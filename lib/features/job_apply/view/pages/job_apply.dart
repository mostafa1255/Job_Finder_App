import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildAboutCompany.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildApplyButton.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildJobDescription.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildJobHeader.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildJobRequirement.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildReviews.dart';

class JobApplyScreen extends StatelessWidget {
  const JobApplyScreen({super.key, required this.job});
  final PostedJob job;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            buildJobHeader(jobApply: job, context: context),
            _buildTabBar(),
            Expanded(child: _buildTabView(job: job)),
            buildApplyButton(context: context, job: job),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      indicator: BoxDecoration(),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.symmetric(horizontal: 20),
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      dividerColor: Colors.transparent,
      tabs: [
        Tab(text: 'Description'),
        Tab(text: 'Requirement'),
        Tab(text: 'About'),
        Tab(text: 'Reviews'),
      ],
    );
  }

  Widget _buildTabView({required PostedJob job}) {
    return TabBarView(
      children: [
        buildJobDescription(jobDescription: job.description!),
        buildJobRequirement(jobRequirement: job.requirements!),
        buildAboutCompany(jobAbout: job.about!),
        buildReviews(),
      ],
    );
  }
}
