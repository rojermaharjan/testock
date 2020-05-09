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
    Rect rect = new Rect.fromCircle(
      center:  Offset(size.width / 2, size.height+4),
      radius: this._radius,
    );

    swipeArcPaint.shader=gradient.createShader(rect);

    canvas.drawCircle(
        Offset(size.width / 2, size.height+4), this._radius, swipeArcPaint);
  }

  SwipeToReveal({Animation<double> animatedRadius})
      : super(repaint: animatedRadius)
  {
    _radius = animatedRadius.value;
      gradient = new RadialGradient(
      colors: <Color>[
        Colors.grey.shade50,

        Colors.white,

      ],
      stops: [
        0.0,
        0.5,

      ],
    );


    swipeArcPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(241, 250, 238, 1)
      ..strokeWidth = 1
      ..isAntiAlias = true;
  }
}
