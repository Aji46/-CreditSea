import 'package:flutter/material.dart';

class StatusMessageCard extends StatelessWidget {
  const StatusMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/hugeicons_property-view.png',
            height: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Application Under Review',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            "We're carefully reviewing your application to ensure everything is in order. Thank you for your patience.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}