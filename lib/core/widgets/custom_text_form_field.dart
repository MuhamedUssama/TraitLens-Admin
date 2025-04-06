import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final String? initialValue;
  final TextEditingController controller;
  final Validator? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool? filled;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.labelText,
    required this.hintText,
    required this.textInputAction,
    required this.keyboardType,
    this.initialValue,
    this.prefixIcon,
    this.filled,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: filled,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
