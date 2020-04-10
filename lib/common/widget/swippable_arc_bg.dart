import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwipableArc extends CustomPainter {
  final Animation<double> _animation;
  double _initialCurveYOffset;

  double _curveMidYOffset;

  double selectedArcStrokeWidth = 8;

  Paint swipeArcPaint;
  Path swipeArcPath;

  Paint swipeArcBorderPaint;
  Path swipeArcBorderPath;

  Paint selectedLeftArcPaint;

  Paint selectedArcPaint;
  Path selectedArcPath;

  SELECTED_TAB _requestedNextTab;
  SELECTED_TAB _lastSelectedTabIndex;

  Animation<double> _selectedTabAnimation;
  Animation<double> _reverseSelectedTabAnimation;

  SwipableArc(
      this._animation,
      this._initialCurveYOffset,
      this._requestedNextTab,
      this._lastSelectedTabIndex,
      this._selectedTabAnimation)
      : super(repaint: _animation) {
    this._curveMidYOffset = this._initialCurveYOffset - .1;

    swipeArcBorderPath = Path();
    swipeArcBorderPaint = Paint();
    swipeArcBorderPaint.style = PaintingStyle.stroke;
    swipeArcBorderPaint.color = Colors.grey.shade500;
    swipeArcBorderPaint.strokeWidth = 1.5;
    swipeArcBorderPaint.isAntiAlias = true;
    swipeArcBorderPaint.maskFilter = MaskFilter.blur(BlurStyle.inner, 5);

    swipeArcPath = Path();
    swipeArcPaint = Paint();
    swipeArcPaint.style = PaintingStyle.fill;
    swipeArcPaint.color = Colors.white;
    swipeArcPaint.strokeWidth = 1;
    swipeArcPaint.isAntiAlias = true;
//    swipeArcPaint.maskFilter = MaskFilter.blur(BlurStyle.inner, 1);

    selectedArcPath = Path();
    selectedArcPaint = Paint();
    selectedArcPaint.style = PaintingStyle.stroke;
    selectedArcPaint.color = Colors.pink;
    selectedArcPaint.strokeWidth = selectedArcStrokeWidth;
    selectedArcPaint.isAntiAlias = true;

    _reverseSelectedTabAnimation = ReverseAnimation(_selectedTabAnimation);
  }

  @override
  void paint(Canvas canvas, Size size) {
    swipeArcBorderPath.reset();
    swipeArcPath.reset();
    selectedArcPath.reset();

    //TODO introduce a scaling factor to middle control point of bezier curve to make curve constitent across all device screen

    double outerControlPointY =
        (_initialCurveYOffset - this._animation.value) * size.height;
    double middleControlPointY =
        (_curveMidYOffset - this._animation.value) * size.height;

    swipeArcPath.moveTo(0, outerControlPointY);
    swipeArcPath.cubicTo(0, outerControlPointY, size.width * .5,
        middleControlPointY, size.width, outerControlPointY);
    swipeArcPath.lineTo(size.width, size.height);
    swipeArcPath.lineTo(0, size.height);
    swipeArcPath.close();

    canvas.drawPath(swipeArcPath, swipeArcPaint);

    swipeArcBorderPath.moveTo(0, outerControlPointY);
    swipeArcBorderPath.cubicTo(0, outerControlPointY, size.width * .5,
        middleControlPointY, size.width, outerControlPointY);


    canvas.drawPath(swipeArcBorderPath, swipeArcBorderPaint);

    if (_requestedNextTab != SELECTED_TAB.NONE) {
      //TODO currently selected arc offset is fixed, later it should be derived from its paint stroke width.
      selectedArcPath.moveTo(-2, outerControlPointY - 4);
      selectedArcPath.cubicTo(-2, outerControlPointY - 4, (size.width + 4) * .5,
          middleControlPointY - 4, size.width + 2, outerControlPointY - 4);

      if (_requestedNextTab == SELECTED_TAB.RIGHT) {
        if (_lastSelectedTabIndex == SELECTED_TAB.LEFT) {
          canvas.clipRect(
              Rect.fromLTRB(
                  size.width * .5 * _selectedTabAnimation.value,
                  0,
                  size.width * .5 +
                      (_selectedTabAnimation.value * (.5 * size.width)),
                  outerControlPointY),
              doAntiAlias: true);
        } else {
          canvas.clipRect(
              Rect.fromLTRB(
                  size.width - (size.width * 0.5 * _selectedTabAnimation.value),
                  0,
                  size.width,
                  outerControlPointY),
              doAntiAlias: true);
        }
      } else {
        if (_lastSelectedTabIndex == SELECTED_TAB.RIGHT) {
          canvas.clipRect(
              Rect.fromLTRB(
                  size.width * .5 * _reverseSelectedTabAnimation.value,
                  0,
                  size.width - (size.width * 0.5 * _selectedTabAnimation.value),
                  outerControlPointY),
              doAntiAlias: true);
        } else {
          canvas.clipRect(
              Rect.fromLTRB(0, 0, size.width * .5 * _selectedTabAnimation.value,
                  outerControlPointY),
              doAntiAlias: true);
        }
      }
      canvas.drawPath(selectedArcPath, selectedArcPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}

enum SELECTED_TAB { RIGHT, LEFT, NONE }
