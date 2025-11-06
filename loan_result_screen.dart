import 'package:flutter/material.dart';
import 'loan_data_model.dart';

class LoanResultScreen extends StatelessWidget {
  const LoanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loan = ModalRoute.of(context)!.settings.arguments as LoanData;
    final double newEmi = loan.loanAmount / 12; // Assume 1-year loan period
    final double dti = ((loan.existingEmi + newEmi) / loan.salary) * 100;

    String eligibilityMessage = "";
    Color resultColor = Colors.green;

    if (loan.age < 21 || loan.age > 60) {
      eligibilityMessage = "Not Eligible ❌ (Age must be between 21 and 60)";
      resultColor = Colors.red;
    } else if (loan.loanAmount > 10 * loan.salary) {
      eligibilityMessage = "Not Eligible ❌ (Loan exceeds 10× monthly salary)";
      resultColor = Colors.red;
    } else if (dti > 60) {
      eligibilityMessage = "Not Eligible ❌ (High Debt-to-Income Ratio: ${dti.toStringAsFixed(1)}%)";
      resultColor = Colors.red;
    } else {
      eligibilityMessage = "Eligible ✅ (DTI: ${dti.toStringAsFixed(1)}%)";
      resultColor = Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Eligibility Result"),
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer Name: ${loan.name}", style: const TextStyle(fontSize: 18)),
                    Text("Age: ${loan.age}", style: const TextStyle(fontSize: 18)),
                    Text("Monthly Salary: ₹${loan.salary}", style: const TextStyle(fontSize: 18)),
                    Text("Existing EMI: ₹${loan.existingEmi}", style: const TextStyle(fontSize: 18)),
                    Text("Loan Amount: ₹${loan.loanAmount}", style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    Text(
                      eligibilityMessage,
                      style: TextStyle(fontSize: 20, color: resultColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(context),
              child: const Text("Go Back", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
