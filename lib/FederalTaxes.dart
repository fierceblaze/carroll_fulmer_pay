// Form W4: Filing Statuses
enum FilingStatus {
  // Single or Married filing separately
  single,
  // Married filing jointly or Qualifying surviving spouse
  married,
  // Head of household
  headOfHousehold
}

// Publication 15-T (2023): Table 3 (Page 9)
enum PayPeriod {
  semiannually,
  quarterly,
  monthly,
  semimonthly,
  biweekly,
  weekly,
  daily,
}

/*
 * This is my truncated, hardcoded version of
 * Form W4: Employee’s Withholding Certificate
 *
 * I would like to add a setting screen to fill out this data.
 */
class W4 {
  final FilingStatus step1c = FilingStatus.single;
  final bool step2check = false;
  final double step3 = 0;
  final double step4a = 0;
  final double step4b = 0;
  final double step4c = 0;
}

/*
 * This is my interpretation of
 * Publication 15-T: Federal Income Tax Withholding Methods (For 2003)
 *
 * Specifically of
 * Worksheet 1A: Employer’s Withholding Worksheet for Percentage Method Tables for Automated Payroll Systems
 */
class FederalTaxes {
  double _pay = 0;
  final PayPeriod _payPeriod = PayPeriod.weekly;
  final W4 _w4 = W4();

  final Map<PayPeriod, double> _table3 = {
    PayPeriod.semiannually: 2,
    PayPeriod.quarterly: 4,
    PayPeriod.monthly: 12,
    PayPeriod.semimonthly: 24,
    PayPeriod.biweekly: 26,
    PayPeriod.weekly: 52,
    PayPeriod.daily: 260
  };

  // Columns A and E are the same.
  // Column B is the same as A without the first item.
  final List<double> _standardSingleColumnA = [
    0,
    5250,
    16250,
    49975,
    100625,
    187350,
    236500,
    583375
  ];
  final List<double> _standardSingleColumnC = [
    0,
    0,
    1100,
    5147,
    16290,
    37104,
    52832,
    174238.25
  ];
  final List<double> _standardSingleColumnD = [0, 10, 12, 22, 24, 32, 35, 37];

  /*
   * Public entry point.
   */
  double calculate(pay) {
    _pay = pay;
    return step4();
  }

  /*
   * Step 1. Adjust the employee's payment amount.
   */
  double _step1() {
    double a = _pay;
    double b = _table3[_payPeriod]!;
    double c = a * b;

    double d = _w4.step4a;
    double e = c + d;
    double f = _w4.step4b;
    double g = 0;

    if (_w4.step2check == false) {
      if (_w4.step1c == FilingStatus.married) {
        g = 12900;
      } else {
        g = 8600;
      }
    }

    double h = f + g;
    double i = e - h;

    // Adjusted Annual Wage Amount (1i)
    return (i < 0) ? 0 : i;
  }

  /*
   * Step 2. Figure the Tentative Withholding Amount
   */
  double _step2() {
    double a = _step1();
    int apm = _annualPercentageMethod(a);
    double b = _standardSingleColumnA[apm];
    double c = _standardSingleColumnC[apm];
    double d = _standardSingleColumnD[apm];
    double e = a - b;
    double f = e * (d / 100);
    double g = c + f;
    double h = g / _table3[_payPeriod]!;

    return h;
  }

  /*
   * Step 3. Account for tax credits
   */
  double _step3() {
    double a = _w4.step3;
    double b = a / _table3[_payPeriod]!;
    double c = _step2() - b;

    return (c < 0) ? 0 : c;
  }

  /*
   * Step 4. Figure the final amount to withhold
   */
  double step4() {
    double a = _w4.step4c;
    double b = _step3() + a;

    return b;
  }

  /*
   * This is a truncated lookup function for
   * Percentage Method Tables for Automated Payroll Systems (Publication 15-T, 2023, Page 11)
   */
  int _annualPercentageMethod(double wage) {
    int lastElement = _standardSingleColumnA.length - 1;
    for (var i = 0; i < _standardSingleColumnA.length; i++) {
      if (wage >= _standardSingleColumnA[i]) {
        if (i == lastElement || wage < _standardSingleColumnA[i + 1]) {
          return i;
        }
      }
    }
    return lastElement;
  }
}
