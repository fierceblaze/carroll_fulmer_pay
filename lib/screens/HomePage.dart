import 'package:flutter/material.dart';

import '../EvalTextField.dart';
import 'ResultsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create the text fields.
  final EvalTextField _milesTextField = EvalTextField(label: 'Miles');
  final EvalTextField _bonusesTextField = EvalTextField(label: 'Bonuses');
  final EvalTextField _deductionsTextField = EvalTextField(label: 'Deductions');

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text Fields
              _milesTextField,
              _bonusesTextField,
              _deductionsTextField,

              // Calculate Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    onPressed: calculate,
                    child: const Text('Calculate'),
                  ),
                ),
              ),

              // Error Text
              SizedBox(
                width: double.infinity,
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
   * Calculate the results.
   */
  void calculate() {
    String errors = '';

    /*
     * Validate the text fields.
     */

    if (!_milesTextField.isValid()) {
      errors += 'Miles data is invalid.\n';
    }

    if (!_bonusesTextField.isValid()) {
      errors += 'Bonus data is invalid.\n';
    }

    if (!_deductionsTextField.isValid()) {
      errors += 'Deduction data is invalid.\n';
    }

    // Check for errors
    if (errors.isNotEmpty) {
      showErrors(errors);
      return;
    }

    /*
     * Evaluate the text fields.
     */

    double miles = 0;
    double bonuses = 0;
    double deductions = 0;

    double? miles_ = _milesTextField.evaluate();
    double? bonuses_ = _bonusesTextField.evaluate();
    double? deductions_ = _deductionsTextField.evaluate();

    if (miles_ == null) {
      errors += 'Could not evaluate miles.\n';
    } else {
      miles = miles_!;
    }

    if (bonuses_ == null) {
      errors += 'Could not evaluate bonuses.\n';
    } else {
      bonuses = bonuses_!;
    }

    if (deductions_ == null) {
      errors += 'Could not evaluate deductions.\n';
    } else {
      deductions = deductions_!;
    }

    // Check for errors
    if (errors.isEmpty) {
      clearErrors();
    } else {
      showErrors(errors);
      return;
    }

    // Navigate to the results page.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          miles: miles,
          bonuses: bonuses,
          deductions: deductions,
        ),
      ),
    );
  }

  /*
   * Clear errors.
   */
  void clearErrors() {
    setState(() {
      errorText = '';
    });
  }

  /*
   * Show errors.
   */
  void showErrors(text) {
    setState(() {
      errorText = 'Errors Found:\n\n$text';
    });
  }
}
