import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/Constants/share_phone.dart';
import 'package:creditsea/view/LoanApplicationPage/Home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pan extends StatefulWidget {
  final String phoneNumber;

  const Pan({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Pan> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<Pan> {
  final _formKey = GlobalKey<FormState>();

 
  final TextEditingController PanController = TextEditingController();
    final SharedController sharedController = Get.find<SharedController>(); 

  String? _selectedGender;
  String? _selectedMaritalStatus;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




Future<void> _savePersonalDetails() async {
  if (_formKey.currentState!.validate()) {
    try {
      DocumentReference userDoc = _firestore.collection("users").doc(widget.phoneNumber);
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        await userDoc.set({
          "PanNo": PanController.text.trim(),
        }, SetOptions(merge: true));

        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isPanVerified", true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Details updated successfully!")),
        );

        
        Get.offAll(() => LoanApplicationPage());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No record found for this phone number.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}




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
                  _buildProgressItem(1, "Register", true),
                  _buildProgressItem(2, "Offer", false),
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
                      const Text(
                        "Verify PAN Number",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),

                        Image.asset('assets/pan.png'),
                  
                           
                                const SizedBox(height: 20),
                          
                                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField("Enter Your PAN Number*", PanController),
                    ),
                  ],
                                ),
                                const SizedBox(height: 24),
                          
                               
                                const SizedBox(height: 24),
                          
                              
                                const SizedBox(height: 24),
                          
                            
                                const SizedBox(height: 32),
                          
                                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _savePersonalDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
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
