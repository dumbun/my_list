import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  /// [InputTextField] input text field helps to add the text field to user to enter the data

  const InputTextField({
    super.key,
    this.controller,
    this.hintText,
    this.fillColor,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.border = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Function? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged as void Function(String)?,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty || value == "") {
              return 'Please enter a valid value';
            }
            return null;
          },
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: TextInputAction.done,
      controller: controller,
      enableSuggestions: true,
      textAlign: TextAlign.start,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: hintText,
        border: border ? const OutlineInputBorder() : const UnderlineInputBorder(),
      ),
    );
  }
}
