import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurveSliceBg extends CustomPainter {
  Paint blueCurvePaint;
  Path blueCurvePath;

  Animation _animation;

  LinearGradient gradient;

  CurveSliceBg(
//    this._animation,
  )
//      : super(repaint: _animation)
  {
    preInit();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    initPaths(size);
    canvas.drawPath(blueCurvePath, blueCurvePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void preInit() {
    blueCurvePath = Path();
    blueCurvePaint = Paint();
    blueCurvePaint.style = PaintingStyle.fill;
    blueCurvePaint.strokeWidth = 1.5;
    blueCurvePaint.isAntiAlias = true;

    gradient=LinearGradient(
      colors: [
        Color.fromRGBO(160, 196, 255,1),
        Color.fromRGBO(255, 255,255, 1),
      ],
      begin: Alignment.topRight,
      end: Alignment.topLeft,
    );
  }

  void initPaths(Size size) {
    blueCurvePath.reset();
    blueCurvePath.moveTo(.3*size.width, 0);
    blueCurvePath.moveTo(size.width, 0);
    blueCurvePath.moveTo(size.width, size.height*.6);



    blueCurvePath.cubicTo(.3*size.width, 0, size.width, 0, size.width, size.height*.6);



    blueCurvePaint.shader=gradient.createShader(blueCurvePath.getBounds());


  }
}
