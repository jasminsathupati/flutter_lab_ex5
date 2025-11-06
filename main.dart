import 'package:flutter/material.dart';
import 'loan_details_screen.dart';
import 'loan_result_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Loan Eligibility Checker",
    initialRoute: '/',
    routes: {
      '/': (context) => const LoanDetailsScreen(),
      '/result': (context) => const LoanResultScreen(),
    },
  ));
}
