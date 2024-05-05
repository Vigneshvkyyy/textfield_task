import 'package:flutter/material.dart';

class CustomNumberTextField extends StatelessWidget {
  final TextEditingController controller;

  final Function(String)? onChanged;

  final Function()? onTap;

  const CustomNumberTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter 1number';
        }
        if (value.length < 3) {
          return 'Please enter at least 3 characters';
        }
        return null;
      },
    );
  }
}
