import 'package:homeradar/constants/constants.dart';
import 'package:flutter/material.dart';

Widget buildForm(
  String label,
  TextEditingController controller, {
  bool readOnly = false,
  onChanged,
  keyboardType,
  maxLines,
  textInputAction,
  hint,
  labelText,
  prefixText,
  suffixText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: flargeText),
      TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          prefixText: prefixText,
          labelText: labelText,
          suffixText: suffixText,
        ),
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter some text";
          }
          return null;
        },
      ),
      const SizedBox(height: 25),
    ],
  );
}
