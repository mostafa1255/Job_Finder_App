import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/job_search_cubit.dart';

class JobListSection extends StatelessWidget {
  final String title;
  final List<String?> items;
  final Function(String, int) onTapItem;


  const JobListSection({
    super.key,
    required this.title,
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: items.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        items[index]!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {

                        onTapItem(items[index]!, index);
                        context
                            .read<JobSearchCubit>()
                            .addRecentSearch(items[index]!);
                      },
                    );
                  },
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
