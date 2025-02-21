import 'package:creditsea/view/Application_satus/widgets/Timeline.dart';
import 'package:flutter/material.dart';

class ApplicationTimeline extends StatelessWidget {
  const ApplicationTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineItem(
          title: 'Application Submitted',
          isCompleted: true,
          color: Colors.green,
        ),
        TimelineItem(
          title: 'Application under Review',
          isActive: true,
          color: Colors.blue,
        ),
        TimelineItem(title: 'E-KYC'),
        TimelineItem(title: 'E-Nach'),
        TimelineItem(title: 'E-Sign'),
        TimelineItem(title: 'Disbursement', isLast: true),
      ],
    );
  }
}