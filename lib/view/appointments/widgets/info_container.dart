import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String text;
  final Icon icon;
  const InfoContainer(
      {super.key, required this.title, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(text),
        ],
      ),
    );
  }
}
