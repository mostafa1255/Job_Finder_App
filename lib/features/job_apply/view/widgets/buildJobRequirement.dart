import 'package:flutter/material.dart';

Widget buildJobRequirement({required List<String> jobRequirement}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: ListView.builder(
            itemCount: jobRequirement.length,
            itemBuilder: (context, index) => Text(
              jobRequirement[index],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
