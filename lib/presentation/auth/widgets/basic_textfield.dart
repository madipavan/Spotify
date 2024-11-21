import 'package:flutter/material.dart';

class BasicTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const BasicTextfield(
      {super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
