import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String hint;
  final String label;
  bool obscure;
  Widget? suffixIcon;
  AutovalidateMode? autovalidateMode;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  CustomTextfieldWidget({
    super.key,
    this.obscure = false,
    required this.hint,
    required this.label,
    this.autovalidateMode,
    this.validator,
    this.controller,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      autovalidateMode: autovalidateMode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,

      cursorColor: Colors.white,
      obscureText: obscure,
      cursorErrorColor: Colors.white,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        hint: Text(hint, style: TextStyle(color: Colors.white)),
        label: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
