import 'package:flutter/material.dart';

import 'invoicenumber_textfieldwidget.dart';

class TextAndTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

   const TextAndTextFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            labelText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: CustomNumberTextField(controller: controller,)
        ),
      ],
    );
  }
}
