import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildAboutCompany.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildApplyButton.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildJobDescription.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildJobHeader.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildJobRequirement.dart';
import 'package:jop_finder_app/features/job_apply/view/widgets/buildReviews.dart';

class JobApplyScreen extends StatelessWidget {
  const JobApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            buildJobHeader(),
            _buildTabBar(),
            Expanded(child: _buildTabView()),
            buildApplyButton(),
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

  Widget _buildTabView() {
    return TabBarView(
      children: [
        buildJobDescription(),
        buildJobRequirement(),
        buildAboutCompany(),
        buildReviews(),
      ],
    );
  }
}
