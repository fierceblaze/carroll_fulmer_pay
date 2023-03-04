class Calculate {
  static const baseRate = 0.37;

  static double basePay(double miles) {
    return miles * baseRate;
  }

  /*
    Miles less than 2,499 paid at $0.46 per mile
    Miles greater than or equal to 2,500 and less than 2,599 paid at $0.47 per mile
    Miles greater than or equal to 2,600 and less than 2,699 paid at $0.48 per mile
    Miles greater than or equal to 2,700 and less than 2,799 paid at $0.50 per mile
    Miles greater than or equal to 2,800 and less than 2,899 paid at $0.52 per mile
    Miles greater than or equal to 2,900 and less than 2,999 paid at $0.54 per mile
    Miles greater than or equal to 3,000 paid at $0.57 per mile
    */
  static double tierPay(double miles) {
    double payRate = 0.0;
    if (miles >= 3000) {
      payRate = 0.57;
    } else if (miles > 2900) {
      payRate = 0.54;
    } else if (miles > 2800) {
      payRate = 0.52;
    } else if (miles > 2700) {
      payRate = 0.50;
    } else if (miles > 2600) {
      payRate = 0.48;
    } else if (miles > 2500) {
      payRate = 0.47;
    } else {
      payRate = 0.46;
    }
    return miles * (payRate - baseRate);
  }

  static double federalTax(double pay) {
    return 0.0;
  }

  static double stateTax(double pay) {
    return 0.0;
  }

  static double medicareTax(double pay) {
    return 0.0;
  }

  static double socialSecurityTax(double pay) {
    return 0.0;
  }
}
