import 'package:flutter/material.dart';
import 'loan_data_model.dart';

class LoanDetailsScreen extends StatefulWidget {
  const LoanDetailsScreen({super.key});

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final salaryController = TextEditingController();
  final emiController = TextEditingController();
  final loanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan Eligibility Form"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Enter Customer Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),

                _buildTextField("Name", nameController, TextInputType.text),
                _buildTextField("Age", ageController, TextInputType.number),
                _buildTextField("Monthly Salary (₹)", salaryController, TextInputType.number),
                _buildTextField("Existing EMI (₹)", emiController, TextInputType.number),
                _buildTextField("Loan Amount Requested (₹)", loanController, TextInputType.number),

                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final loan = LoanData(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        salary: double.parse(salaryController.text),
                        existingEmi: double.parse(emiController.text),
                        loanAmount: double.parse(loanController.text),
                      );
                      Navigator.pushNamed(context, '/result', arguments: loan);
                    }
                  },
                  child: const Text("Check Eligibility", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Enter $label";
          if (type == TextInputType.number && double.tryParse(value) == null) {
            return "Enter a valid number";
          }
          return null;
        },
      ),
    );
  }
}
