import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(60, 0);
    path.lineTo(60, size.height * 0.65);
    path.quadraticBezierTo(
        60, size.height * 0.65 + 30, 30, size.height * 0.65 + 30);
    path.quadraticBezierTo(
        0, size.height * 0.65 + 30, 0, size.height * 0.65 + 60);
    path.quadraticBezierTo(
        0, size.height * 0.65 + 90, 30, size.height * 0.65 + 90);
    path.quadraticBezierTo(
        60, size.height * 0.65 + 90, 60, size.height * 0.65 + 120);

    path.moveTo(60, size.height * 0.65 + 120);
    path.lineTo(60, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.65 + 120);

    path.quadraticBezierTo(size.width, size.height * 0.65 + 90, size.width - 30,
        size.height * 0.65 + 90);
    path.quadraticBezierTo(size.width - 60, size.height * 0.65 + 90,
        size.width - 60, size.height * 0.65 + 60);
    path.quadraticBezierTo(size.width - 60, size.height * 0.65 + 30,
        size.width - 30, size.height * 0.65 + 30);
    path.quadraticBezierTo(
        size.width, size.height * 0.65 + 30, size.width, size.height * 0.65);

    path.lineTo(size.width, 0);
    path.lineTo(60, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
