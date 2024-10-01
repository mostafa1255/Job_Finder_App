import 'package:flutter/material.dart';

class JobApplyScreen extends StatelessWidget {
  const JobApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            _buildJobHeader(),
            _buildTabBar(),
            Expanded(child: _buildTabView()),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildJobHeader() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xff2C557D),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {},
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Image.network(
                    'https://logo.clearbit.com/google.com',
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(width: 60),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Product Designer',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              'Google',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                    label: const Text('Design',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blue[900]),
                Chip(
                    label: const Text('Full-Time',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blue[900]),
                Chip(
                    label: const Text('Junior',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blue[900]),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$160,000/year', style: TextStyle(color: Colors.white)),
                SizedBox(width: 16),
                Text('California, USA', style: TextStyle(color: Colors.white)),
              ],
            ),
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
        _buildJobDescription(),
        _buildJobRequirement(),
        _buildAboutCompany(),
        _buildReviews(),
      ],
    );
  }

  Widget _buildJobDescription() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobRequirement() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCompany() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '• A great place to work with tons of growth opportunities.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Color(0xff2C557D),
          ),
          child: const Text(
            'Apply Now',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
