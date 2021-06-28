import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final imagePath;
  final h;
  final w;

  LogoImage({this.imagePath, this.h = 100.0, this.w = 100.0});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: h,
      width: w,
    );
  }
}
