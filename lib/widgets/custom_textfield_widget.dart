import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String hint;
  final String label;
  bool? obscure = false;
  Widget? suffixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Function(String)? onchanged;
  CustomTextfieldWidget({
    super.key,
    this.obscure,
    required this.hint,
    required this.label,

    this.validator,
    this.controller,
    this.onchanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),

      controller: controller,
      validator: validator,
      onChanged: onchanged,

      cursorColor: Colors.white,
      obscureText: obscure!,
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
