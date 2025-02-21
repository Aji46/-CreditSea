import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/Constants/share_phone.dart';
import 'package:creditsea/view/Application_satus/application_staus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurOffer extends StatefulWidget {


  const OurOffer({Key? key,}) : super(key: key);

  @override
  State<OurOffer> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<OurOffer> {
  final _formKey = GlobalKey<FormState>();


    final SharedController sharedController = Get.find<SharedController>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
      ),
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProgressItem(1, "Register", false),
                  _buildProgressItem(2, "Offer", true),
                  _buildProgressItem(3, "Approval", false),
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
              color: Color.fromARGB(228, 239, 238, 238),
              width: 2,
            ),
          ),
                child: Padding(
                          padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),  
                        Image.asset('assets/offer.png'),
                        SizedBox(height: 50,),              
                                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                       Get.offAll(() => const ApplicationStatusPage(applicationNumber: '#CS12323',));  
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Accept Offer',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                                ),
                                SizedBox(height: 10,),
                                   SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: Colors.blue, width: 2),
    ),
  ),
  child: const Text(
    'Extend Offer',
    style: TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
),

                                ),
                                const SizedBox(height: 150),
                                
                  ],
                  ),
                )
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label.replaceAll("*", ""),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
        ),
      ],
    );
  }



  Widget _buildProgressItem(int number, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? Colors.blue : Colors.grey[300],
          child: Text(number.toString(), style: TextStyle(color: isActive ? Colors.white : Colors.grey[600])),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? Colors.blue : Colors.grey[600], fontWeight: FontWeight.w500)),
      ],
    );
  }
}
