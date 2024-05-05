import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool isView;
  final Function()? onTap;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.onChanged,
    required this.isView,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: isView ? "" : labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter customer name';
        }
        return null;
      },
    );
  }
}
