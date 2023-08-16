import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final double height;
  final double width;
  final List<BoxShadow>? boxShadow;
  AppIconButton({required this.icon, this.height = 40, this.width = 40, this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icon,
    );
  }
}
