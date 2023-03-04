import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calculate.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage(
      {super.key,
      required this.miles,
      required this.bonuses,
      required this.deductions});

  final double miles;
  final double bonuses;
  final double deductions;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  int rowNum = 0;

  @override
  Widget build(BuildContext context) {
    // Calculations
    double miles = widget.miles;
    double bonuses = widget.bonuses;
    double deductions = widget.deductions;
    double basePay = Calculate.basePay(miles);
    double tierPay = Calculate.tierPay(miles);
    double grossPay = basePay + bonuses;
    double taxFederal = Calculate.federalTax(grossPay);
    double taxState = Calculate.stateTax(grossPay);
    double taxMedicare = Calculate.medicareTax(grossPay);
    double taxSocialSecurity = Calculate.socialSecurityTax(grossPay);
    double taxes = taxFederal + taxState + taxMedicare + taxSocialSecurity;
    double netPay = basePay + tierPay + bonuses - deductions - taxes;

    // Build
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                quickRow('Miles', miles.toString()),
                blankRow(),
                headerRow('Earnings', ''),
                quickRow('Gross Pay', usd(grossPay)),
                quickRow('Bonuses', usd(bonuses)),
                blankRow(),
                headerRow('Deductions', ''),
                quickRow('Deductions', usd(deductions)),
                quickRow('Travel Expense', usd(tierPay * -1)),
                blankRow(),
                headerRow('Taxes', ''),
                quickRow('Federal', usd(taxFederal)),
                quickRow('Medicare', usd(taxMedicare)),
                quickRow('Social Security', usd(taxSocialSecurity)),
                quickRow('State', usd(taxState)),
                blankRow(),
                quickRow('Net Pay', usd(netPay)),

                /*
                 * OK Button
                 */
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
   * Shortcut method to format currency.
   */
  String usd(double amt) {
    return NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2)
        .format(amt);
  }

  /*
   * Shortcut method to create blank rows.
   */
  Widget blankRow() {
    return quickRow(' ', ' ');
  }

  /*
   * Shortcut method to create header rows.
   */
  Widget headerRow(String row1, String row2) {
    rowNum++;
    return Container(
      color: (rowNum % 2 == 0) ? Colors.black12 : Colors.black26,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              row1.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(row2),
          ),
        ],
      ),
    );
  }

  /*
   * Shortcut method to create rows.
   */
  Widget quickRow(String row1, String row2) {
    rowNum++;
    return Container(
      color: (rowNum % 2 == 0) ? Colors.black12 : Colors.black26,
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: Text(row1),
          ),
          Expanded(
            child: Text(row2),
          ),
        ],
      ),
    );
  }
}
