import 'package:flutter/material.dart';

import 'evalText.dart';

class EvalTextField extends StatefulWidget {
  EvalTextField({Key? key, required this.label}) : super(key: key);

  final String label;

  bool isValid = false;
  String text = '';

  double? evaluate() {
    return EvalText.eval(text);
  }

  @override
  State<EvalTextField> createState() => _EvalTextFieldState();
}

class _EvalTextFieldState extends State<EvalTextField> {
  final _controller = TextEditingController();

  /*
   * Error text for validation.
   */
  String? get _errorText {
    final text = _controller.text;

    widget.isValid = false;

    // Check if the text is empty
    if (text.isEmpty) return "Should not be empty";

    // Check if the text matches out pattern.
    if (!EvalText.isValid(text))
      return "Invalid expression. Example: 1 + 2 - 3";

    widget.isValid = true;

    // return null if the text is valid
    return null;
  }

  /*
   * This seems extra to me.
   */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /*
   * Build the widget.
   */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          label: Text(widget.label),
          // hintText: 'Enter Miles',
          errorText: _errorText,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: onClearPressed,
            icon: Icon(Icons.cancel),
          ),
        ),
        onChanged: onTextChanged,
      ),
    );
  }

  /*
   * Handle pressing the clear icon.
   */
  void onClearPressed() {
    _controller.clear();
    widget.text = _controller.text;
    setState(() {});
  }

  /*
   * Handle changes to the text.
   */
  void onTextChanged(text) {
    widget.text = _controller.text;
    setState(() {});
  }
}