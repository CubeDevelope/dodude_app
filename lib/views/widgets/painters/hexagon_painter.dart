import 'dart:math';

import 'package:flutter/material.dart';

class HexagonPainter extends ShapeBorder {

  final double factorScale;


  const HexagonPainter({this.factorScale = 1});

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();

    double centerX = rect.width / 2;
    double centerY = rect.height / 2;

    double radius = min(centerX, centerY) * factorScale;

    double angle = 2 * pi / 6;

    path.moveTo(centerX, centerY + radius);


    for (int i = 0; i < 6; i++) {
      double controlPointX = centerX + radius * sin(angle * i);
      double controlPointY = centerY + radius * cos(angle * i);
      path.lineTo(controlPointX, controlPointY);
    }

    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return HexagonPainter(factorScale: t);
  }

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

}
