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
  final bool readOnly;
  final void Function()? onTap;

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
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
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
      readOnly: readOnly,
      onTap: onTap,
      style: Theme.of(context).textTheme.titleSmall,
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
