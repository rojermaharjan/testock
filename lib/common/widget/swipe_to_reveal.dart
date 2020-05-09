import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeToReveal extends CustomPainter {
  Paint swipeArcPaint;

  double _radius;

  RadialGradient gradient;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {


    canvas.drawCircle(
        Offset(size.width / 2, size.height+4), this._radius, swipeArcPaint);
  }

  SwipeToReveal({Animation<double> animatedRadius})
      : super(repaint: animatedRadius)
  {
    _radius = animatedRadius.value;


    swipeArcPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(247, 255, 247, 1)
      ..strokeWidth = 1
      ..isAntiAlias = true;
  }
}
