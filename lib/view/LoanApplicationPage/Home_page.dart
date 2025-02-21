import 'package:creditsea/view/offerPage/our_offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanApplicationPage extends StatefulWidget {
  const LoanApplicationPage({Key? key}) : super(key: key);

  @override
  State<LoanApplicationPage> createState() => _LoanApplicationPageState();
}

class _LoanApplicationPageState extends State<LoanApplicationPage> {
  String? _selectedPurpose;
  double _principalAmount = 30000;
  int _tenure = 40;
  final double _interestRate = 1.0; 
  final double _processingFee = 10.0; 
  bool _isEligible = false;

  @override
  Widget build(BuildContext context) {
    double totalInterest = (_principalAmount * _interestRate / 100) * _tenure;
    double totalPayable = _principalAmount + totalInterest + (_principalAmount * _processingFee / 100);

    _isEligible = _principalAmount <= 100000 && _tenure <= 45;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/home_top.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Apply for loan',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ],
              ),
              const Text(
                "We've calculated your loan eligibility. Select your preferred loan amount and tenure.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Interest Per Day $_interestRate%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Processing Fee $_processingFee%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Text(
                'Purpose of Loan*',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Select purpose of loan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                value: _selectedPurpose,
                items: ['Personal', 'Business', 'Education', 'Medical']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedPurpose = value);
                },
              ),

              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Principal Amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '₹ ${_principalAmount.toInt()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Slider(
                value: _principalAmount,
                min: 1000,
                max: 100000,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() => _principalAmount = value);
                },
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tenure',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '$_tenure Days',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Slider(
                value: _tenure.toDouble(),
                min: 20,
                max: 45,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() => _tenure = value.toInt());
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('20 Days'),
                  Text('45 Days'),
                ],
              ),

              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Principle Amount', '₹${_principalAmount.toInt()}'),
                    const SizedBox(height: 8),
                    _buildDetailRow('Interest', '₹${totalInterest.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    _buildDetailRow('Processing Fee', '₹${(_principalAmount * _processingFee / 100).toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    _buildDetailRow('Total Payable', '₹${totalPayable.toStringAsFixed(2)}'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: Text(
                  _isEligible
                      ? 'You are eligible for this loan.'
                      : 'You are not eligible for this loan.',
                  style: TextStyle(
                    color: _isEligible ? Colors.green : Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isEligible
                      ? () {
                          // Mock submission process
                          _submitLoanApplication();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Loan application submitted successfully!'),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _submitLoanApplication() {
    Get.offAll(() => const OurOffer());  
    final loanApplication = {
      'purpose': _selectedPurpose,
      'principalAmount': _principalAmount,
      'tenure': _tenure,
      'interestRate': _interestRate,
      'processingFee': _processingFee,

        
    };
 
  }
} 