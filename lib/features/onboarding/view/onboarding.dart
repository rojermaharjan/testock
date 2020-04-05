import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingState();
  }
}

class _OnBoardingState extends State<StatefulWidget>
    with TickerProviderStateMixin {
  AnimationController _onboardingAnimationController;

  Animation _curveExpansionAnimation;
  final double _curveExpansionEndValue = .3;

  SELECTED_TAB currentSelectedTabIndex = SELECTED_TAB.NONE;

  AnimationController _tabSelectedAnimationController;

  Animation<int> _tabSelectionAnimation;

  @override
  Widget build(BuildContext context) {
    return _getJhonnyVinoOnBoardingScreen();
  }

  @override
  void initState() {
    super.initState();

    _onboardingAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500),
        );



    _onboardingAnimationController.addListener(() {
      _onTabSelected(SELECTED_TAB.LEFT, 300);
    });

    _curveExpansionAnimation =
        Tween<double>(begin: 0, end: _curveExpansionEndValue).animate(
            CurvedAnimation(
                curve: Curves.elasticOut, parent: _onboardingAnimationController));


    _tabSelectedAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )..addListener(() {
      setState(() {
    });});


    _tabSelectionAnimation=  IntTween(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Curves.easeOut, parent: _tabSelectedAnimationController));

  }

  _onTabSelected(SELECTED_TAB selectedTabIndex, int delayInMilli) {
    this.currentSelectedTabIndex = selectedTabIndex;
    Future.delayed(Duration(milliseconds: delayInMilli), () {
      _tabSelectedAnimationController.forward(from:0);
    });
  }

  Widget _getJhonnyVinoOnBoardingScreen() {
    return Stack(
      children: <Widget>[
        Container(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: SwipableArc(
                  _curveExpansionAnimation, currentSelectedTabIndex,_tabSelectionAnimation),
            )),
        _getHeaderLoginRegisterView(),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                    onPressed: this.startAnimation,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.black)),
                    child: Text(
                      'Swipe',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Lalezar',
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ))))
      ],
    );
  }

  void onLoginBtnPressed() {}

  void onRegisterBtnPressed() {}

  void startAnimation() {
    _onboardingAnimationController.forward(from: 0);
  }

  Widget _getHeaderLoginRegisterView() {
    return AnimatedBuilder(
      animation: _onboardingAnimationController,
      builder: (context, builder) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: ()=>_onTabSelected(SELECTED_TAB.LEFT, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Opacity(
                        opacity: _onboardingAnimationController.value,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ))),
              ),
            )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap:()=> _onTabSelected(SELECTED_TAB.RIGHT, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Opacity(
                            opacity: _onboardingAnimationController.value,
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'Lalezar',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ))),
                  ),
                )),

          ],
        );
      },
    );
  }

  Widget _getHeaderLogoView() {
    return ScaleTransition(
      scale: _onboardingAnimationController,
      child: Icon(Icons.account_circle),
    );
  }
}

class SwipableArc extends CustomPainter {
  final Animation<double> _animation;
  double _curveHeightScale = .6;
  double _curveFocalControlPointHeightScale = .40;

  double selectedArcStrokeWidth = 8;

  Paint swipeArcPaint;
  Path swipeArcPath;

  Paint selectedLeftArcPaint;

  Paint selectedRightArcPaint;
  Path selectedRightArcPath;

  SELECTED_TAB _currentSelectedTabIndex;

  Animation<int> _selectedTabAnimation;

  SwipableArc(this._animation, this._currentSelectedTabIndex,this._selectedTabAnimation)
      : super(repaint: _animation) {

    swipeArcPath = Path();
    swipeArcPaint = Paint();
    swipeArcPaint.style = PaintingStyle.fill;
    swipeArcPaint.color = Colors.white;
    swipeArcPaint.strokeWidth = 1;
    swipeArcPaint.isAntiAlias = true;
    swipeArcPaint.maskFilter = MaskFilter.blur(BlurStyle.solid, 1.3);

    selectedRightArcPath = Path();
    selectedRightArcPaint = Paint();
    selectedRightArcPaint.style = PaintingStyle.stroke;
    selectedRightArcPaint.color = Colors.pink;
    selectedRightArcPaint.strokeWidth = selectedArcStrokeWidth;
    selectedRightArcPaint.isAntiAlias = true;
//    selectedRightArcPaint.maskFilter = MaskFilter.blur(BlurStyle.solid, 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    swipeArcPath.reset();
    selectedRightArcPath.reset();
    //TODO introduce a scaling factor to middle control point of bezier curve to make curve constitent across all device screen

    double outerControlPointY =
        (_curveHeightScale - this._animation.value) * size.height;
    double middleControlPointY =
        (_curveFocalControlPointHeightScale - this._animation.value) *
            size.height;

    swipeArcPath.moveTo(0, outerControlPointY);
    swipeArcPath.cubicTo(0, outerControlPointY, size.width * .5,
        middleControlPointY, size.width, outerControlPointY);
    swipeArcPath.lineTo(size.width, size.height);
    swipeArcPath.lineTo(0, size.height);
    swipeArcPath.close();

    canvas.drawPath(swipeArcPath, swipeArcPaint);


//    canvas.save();
//
    if (_currentSelectedTabIndex != SELECTED_TAB.NONE) {
      //TODO currently selected arc offset is fixed, later it should be derived from its paint stroke width.
      selectedRightArcPath.moveTo(-2, outerControlPointY - 4);
      selectedRightArcPath.cubicTo(
          -2,
          outerControlPointY - 4,
          (size.width + 4) * .5,
          middleControlPointY - 4,
          size.width + 2,
          outerControlPointY - 4);


      if (_currentSelectedTabIndex ==SELECTED_TAB.RIGHT) {
        canvas.clipRect(
            Rect.fromLTRB(size.width * .5*_selectedTabAnimation.value, 0, size.width, outerControlPointY),
            doAntiAlias: true);
      } else {
        canvas.clipRect(
            Rect.fromLTRB(0, 0, size.width * .5*_selectedTabAnimation.value, outerControlPointY),
            doAntiAlias: true);
      }
      canvas.drawPath(selectedRightArcPath, selectedRightArcPaint);
    }
//    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;


}

enum SELECTED_TAB{
    RIGHT,LEFT,NONE
}
