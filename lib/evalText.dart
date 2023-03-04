class EvalText {
  /*
   * Checks if the text is in a valid format. (mostly)
   */
  static isValid(text) {
    return text.contains(RegExp(r'^[0-9\/ *.+-]+$'));
  }

  /*
   * The text the text. Return null on error.
   */
  static double? eval(text) {
    int lastFound = 0;
    int nextFind = 0;
    String nextOperation = '';
    double total = 0;

    // If the text is empty or an invalid format then exit.
    if (text.isEmpty || !isValid(text)) return null;

    // Remove any spaces.
    text = text.replaceAll(RegExp(r' '), '');

    // Find the first operation.
    nextFind = text.indexOf(RegExp(r'[\\*+-]'));

    // If there are no further operations...
    if (nextFind == -1) {
      // Try parsing the text as a number and return it and exit.
      return double.tryParse(text);
    }

    // Get and parse the first number.
    double? nextNumber = double.tryParse(text.substring(lastFound, nextFind));

    // If the number didn't parse then return the error and exit.
    if (nextNumber == null) return null;

    // Set the new total.
    total = nextNumber;

    // print('$label = $total');

    while (true) {
      // Get the next operation.
      lastFound = nextFind;
      nextFind++;
      nextOperation = text.substring(lastFound, nextFind);

      // Get the next number.
      lastFound = nextFind;
      nextFind = text.indexOf(RegExp(r'[\/*+-]'), lastFound);

      // This is the last number
      if (nextFind == -1) {
        nextNumber = double.tryParse(text.substring(lastFound));
      } else {
        nextNumber = double.tryParse(text.substring(lastFound, nextFind));
      }

      if (nextNumber == null) return null;

      if (nextOperation == '+') {
        total += nextNumber;
      } else if (nextOperation == '-') {
        total -= nextNumber;
      } else if (nextOperation == '*') {
        total *= nextNumber;
      } else if (nextOperation == '/') {
        total /= nextNumber;
      }

      // print('$label $nextOperation $nextNumber = $total');

      if (nextFind == -1) break;
    }

    return total;
  }
}
