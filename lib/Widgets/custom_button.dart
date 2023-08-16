import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double? width;
  final String buttonText;

  CustomButton({
    this.height = 70,
    this.width = double.infinity,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.mainColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
