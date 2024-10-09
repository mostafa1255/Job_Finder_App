import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String company;
  final String title;
  final String salary;
  final String location;
  final List<String> tags;
  final Color color;

  const JobCard({
    super.key,
    required this.company,
    required this.title,
    required this.salary,
    required this.location,
    required this.tags,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0,bottom: 16.0),
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          // Setting the card background with opacity
          color: color, // Adjust the background opacity here
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Name
              Text(
                company,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 2),

              // Job Title
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),

              // Tags (now wrapped to avoid overflow)
              Wrap(
                spacing: 4.0, // Space between tags
                children: tags.map((tag) {
                  return Opacity(
                    opacity: 1.0,
                    child: Card(
                      color: Colors.white24.withOpacity(
                          0.3), // Semi-transparent background for the tags
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),

              // Salary
              Text(
                salary,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),

              // Location
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
