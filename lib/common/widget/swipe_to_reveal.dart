import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeToReveal extends CustomPainter {
  Paint swipeArcPaintBounce;

  double _radius;


  Paint swipeArcPaintReveal;

  STATE state;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {


    canvas.drawCircle(
        Offset(size.width / 2, size.height+4), this._radius, state==STATE.RESTING?swipeArcPaintReveal:swipeArcPaintBounce);
  }

  SwipeToReveal({Animation<double> animatedRadius,this.state})
      : super(repaint: animatedRadius)
  {
    _radius = animatedRadius.value;


    swipeArcPaintBounce = Paint()
      ..style = PaintingStyle.fill
//      ..color = Color.fromRGBO(247, 255, 247, 1)
      ..color = Colors.grey.shade50
      ..strokeWidth = 1
      ..isAntiAlias = true;

    swipeArcPaintReveal = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade100
      ..isAntiAlias = true;
  }

}

enum STATE
{
    INITIAL,RESTING
}
