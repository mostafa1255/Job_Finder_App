import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';

Widget buildJobHeader(
    {required PostedJob jobApply, required BuildContext context}) {
  return SafeArea(
    child: Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xff2C557D),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () => GoRouter.of(context).pop(),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: jobApply.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: jobApply.imageUrl!,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        )
                      : const Icon(Icons.person),
                ),
              ),
              const SizedBox(width: 60),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            jobApply.jobTitle ?? '',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            jobApply.companyName ?? '',
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                  label: const Text('Full Time',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.blue[900]),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(jobApply.salary ?? '',
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 16),
              Text(jobApply.location ?? '',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    ),
  );
}
