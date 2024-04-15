import 'package:flutter/material.dart';

class BuildForm extends StatelessWidget {
  const BuildForm({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 95, minHeight: 95),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF909090),
                fontSize: 14,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                helperText: ' ',
              ),
              validator: validator,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
