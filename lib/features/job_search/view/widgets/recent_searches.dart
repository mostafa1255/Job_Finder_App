import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      foregroundDecoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.history,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const Expanded(
            child: SizedBox(
              width: double.infinity,
            ),
          ),
          const Icon(
            Icons.cancel,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
