// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProposalsScreen extends StatelessWidget {
  final List<Proposal> proposals = [
    Proposal('Google', 'Jr Executive', '\$115,000/y', 'Non-Negotiable',
        '13/5/22', 'Los Angeles, US', Colors.redAccent),
    Proposal('Beats', 'Mid Executive', '\$86,000/y', 'Negotiable', '13/5/22',
        'San Jose, US', Colors.greenAccent),
    Proposal('Spotify', 'Sr Executive', '\$96,000/y', 'Negotiable', '13/5/22',
        'San Francisco, US', Colors.greenAccent),
  ];

  ProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(227, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(227, 255, 255, 255),
        title: Text('Proposals'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://picsum.photos/200/300'), // Placeholder for profile image
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have ${proposals.length} Proposals ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: proposals.length,
                itemBuilder: (context, index) {
                  return ProposalCard.ProposalCard(proposal: proposals[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Proposal {
  final String company;
  final String title;
  final String salary;
  final String status;
  final String joiningDate;
  final String location;
  final Color statusColor;

  Proposal(this.company, this.title, this.salary, this.status, this.joiningDate,
      this.location, this.statusColor);
}

class ProposalCard extends StatelessWidget {
  final Proposal proposal;

  const ProposalCard.ProposalCard({super.key, required this.proposal});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Placeholder for company logos
                    CircleAvatar(
                      radius: 35,
                      foregroundImage: NetworkImage(
                        'https://picsum.photos/200/300', // Replace with actual company logo URL
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          proposal.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          proposal.company,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(proposal.joiningDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    SizedBox(height: 4),
                    Text(proposal.location,
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(proposal.salary, style: TextStyle(fontSize: 16)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: proposal.statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    proposal.status,
                    style: TextStyle(color: proposal.statusColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
