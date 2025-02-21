
import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;
  final Color color;

  const TimelineItem({
    Key? key,
    required this.title,
    this.isCompleted = false,
    this.isActive = false,
    this.isLast = false,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor = isCompleted || isActive ? color : Colors.grey;

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isCompleted || isActive ? color : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.task, color: iconColor),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                          color: iconColor,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}