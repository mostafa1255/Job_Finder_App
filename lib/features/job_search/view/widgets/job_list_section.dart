import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/job_search_cubit.dart';

class JobListSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String) onTapItem;

  const JobListSection({
    super.key,
    required this.title,
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: items.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index], textAlign: TextAlign.center),
                      onTap: () {
                        onTapItem(items[index]);
                        context
                            .read<JobSearchCubit>()
                            .addRecentSearch(items[index]);
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
