 import 'package:flutter/material.dart';

Widget buildJobHeader() {
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

