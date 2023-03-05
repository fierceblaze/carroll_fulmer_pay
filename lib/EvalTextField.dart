import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'evalText.dart';

class EvalTextField extends StatefulWidget {
  EvalTextField({Key? key, required this.label}) : super(key: key);

  final String label;

  String text = '';

  bool isValid() {
    return EvalText.isValid(text);
  }

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

    // Check if the text is empty
    if (text.isEmpty) {
      return "Should not be empty";
    }

    // Check if the text matches out pattern.
    if (!EvalText.isValid(text)) {
      return "Invalid expression. Example: 1 + 2 - 3";
    }

    // return null if the text is valid
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  //Loading counter value on start
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.text = (prefs.getString(widget.label) ?? '0');
      _controller.text = widget.text;
    });
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
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: onClearPressed,
            icon: const Icon(Icons.cancel),
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
  Future<void> onTextChanged(text) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.text = _controller.text;
      prefs.setString(widget.label, widget.text);
    });
  }
}
