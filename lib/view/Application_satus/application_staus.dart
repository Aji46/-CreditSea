import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/view/Application_satus/widgets/Application_time_line.dart';
import 'package:creditsea/view/Application_satus/widgets/Status_message.dart';
import 'package:creditsea/view/Application_satus/widgets/StepIndicator.dart';
import 'package:flutter/material.dart';

class ApplicationStatusPage extends StatelessWidget {
  final String applicationNumber;

  const ApplicationStatusPage({
    super.key,
    required this.applicationNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
     appBar: PreferredSize(
  preferredSize: const Size.fromHeight(20),
  child: AppBar(
    backgroundColor: MyColors.backgroundColor,
  ),
),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StepIndicator(
                    number: "1", label: "Register", isCompleted: true),
                StepIndicator(number: "2", label: "Offer", isCompleted: true),
                StepIndicator(number: "3", label: "Approval", isActive: true),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    offset: Offset(-2, -2),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
                border: Border.all(
                  color:const Color.fromARGB(228, 239, 238, 238),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                  
                    Row(
                      children: [
                             IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                    ),
                        const Text("Application Status",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Loan application no. $applicationNumber',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const ApplicationTimeline(),
                    const StatusMessageCard(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
