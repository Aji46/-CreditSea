
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final String number;
  final String label;
  final bool isCompleted;
  final bool isActive;

  const StepIndicator({
    Key? key,
    required this.number,
    required this.label,
    this.isCompleted = false,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Colors.blue
                : (isCompleted ? Colors.grey : Colors.grey.shade200),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: isActive || isCompleted ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}