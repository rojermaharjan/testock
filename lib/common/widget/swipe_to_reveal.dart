import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeToReveal extends CustomPainter {
  Paint swipeArcPaintBounce;

  double _radius;

  Paint swipeArcPaintReveal;

  STATE state;

  LinearGradient gradient;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    if (state != STATE.INITIAL) {
//      Rect rect = new Rect.fromCircle(
//        center: Offset(size.width / 2, size.height + 4),
//        radius: this._radius,
//      );
//
//      swipeArcPaintReveal.shader=gradient.createShader(rect);

      canvas.drawCircle(Offset(size.width / 2, size.height + 4), this._radius,
          swipeArcPaintReveal);
    } else {
      canvas.drawCircle(Offset(size.width / 2, size.height + 4), this._radius,
          swipeArcPaintBounce);
    }
  }

  SwipeToReveal({Animation<double> animatedRadius, this.state})
      : super(repaint: animatedRadius) {
    _radius = animatedRadius.value;

    swipeArcPaintBounce = Paint()
      ..style = PaintingStyle.fill
//      ..color = Color.fromRGBO(247, 255, 247, 1)
      ..color = Colors.grey.shade50
      ..strokeWidth = 1
      ..isAntiAlias = true;

    swipeArcPaintReveal = Paint()
      ..style = PaintingStyle.fill
      ..color=  Color.fromRGBO(20, 51, 40,1)
      ..isAntiAlias = true;

    gradient=LinearGradient(
      colors: [
        Color.fromRGBO(160, 196, 255,1),
      Color.fromRGBO(255, 255,255, 1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}

enum STATE { INITIAL, RESTING }
