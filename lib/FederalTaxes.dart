enum FilingStatus {
  single, // Single or Married filing separately
  married, // Married filing jointly or Qualifying surviving spouse
  headOfHousehold // Head of household
}

// table3
enum PayPeriod {
  semiannually,
  quarterly,
  monthly,
  semimonthly,
  biweekly,
  weekly,
  daily,
}

class FederalTaxes {
  FilingStatus w4_1c = FilingStatus.single;
  bool w4_checkbox = false;
  double w4_3 = 0;
  double w4_4a = 0;
  double w4_4b = 0;
  double w4_4c = 0;

  double pay = 0;
  PayPeriod payPeriod = PayPeriod.weekly;

  final Map<PayPeriod, double> table3 = {
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
  final List<double> standardSingleColumnA = [
    0,
    5250,
    16250,
    49975,
    100625,
    187350,
    236500,
    583375
  ];
  final List<double> standardSingleColumnC = [
    0,
    0,
    1100,
    5147,
    16290,
    37104,
    52832,
    174238.25
  ];
  final List<double> standardSingleColumnD = [0, 10, 12, 22, 24, 32, 35, 37];

  double calculate(pay) {
    this.pay = pay;
    return step4();
  }

  // Step 1. Adjust the employee's payment amount.
  double step1() {
    double a = pay;
    double b = table3[payPeriod]!;
    double c = a * b;

    double d = w4_4a;
    double e = c + d;
    double f = w4_4b;
    double g = 0;

    if (w4_checkbox == false) {
      if (w4_1c == FilingStatus.married) {
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

  // Step 2. Figure the Tentative Withholding Amount
  double step2() {
    double a = step1();
    int apm = annualPercentageMethod(a);
    double b = standardSingleColumnA[apm];
    double c = standardSingleColumnC[apm];
    double d = standardSingleColumnD[apm];
    double e = a - b;
    double f = e * (d / 100);
    double g = c + f;
    double h = g / table3[payPeriod]!;

    return h;
  }

  // Step 3. Account for tax credits
  double step3() {
    double a = w4_3;
    double b = a / table3[payPeriod]!;
    double c = step2() - b;

    return (c < 0) ? 0 : c;
  }

  // Step 4. Figure the final amount to withhold
  double step4() {
    double a = w4_4c;
    double b = step3() + a;

    return b;
  }

  int annualPercentageMethod(double wage) {
    int lastElement = standardSingleColumnA.length - 1;
    for (var i = 0; i < standardSingleColumnA.length; i++) {
      if (wage >= standardSingleColumnA[i]) {
        if (i == lastElement || wage < standardSingleColumnA[i + 1]) {
          return i;
        }
      }
    }
    return lastElement;
  }
}
