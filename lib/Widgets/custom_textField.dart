import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextInputType? keyBoardType;

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    this.isObscureText = false,
    this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      obscureText: isObscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        //  label: Text('Email'),
        labelStyle: TextStyle(color: Colors.black),
        focusColor: Colors.black,
      ),
    );
  }
}
