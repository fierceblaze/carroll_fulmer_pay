import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              quickRow('Miles:', widget.miles.toString()),
              blankRow(),
              quickRow('Gross Pay:', usd(0)),
              blankRow(),
              quickRow('Bonuses:', usd(widget.bonuses)),
              blankRow(),
              quickRow('Deductions:', usd(widget.deductions)),
              blankRow(),
              quickRow('Net Pay:', '\$0.00'),

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
