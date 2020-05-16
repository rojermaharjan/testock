import 'package:testockmbl/common/widget/swipe_to_reveal.dart';

import 'package:flutter/widgets.dart';

class GettingStartedContainer extends StatefulWidget {
  final AnimationController animationController;

  final double _screenHeight;

  final ANIMATION_STATUS currentSceneState;


  GettingStartedContainer(this.animationController,this._screenHeight,this.currentSceneState);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GettingStartedContainerState(animationController,_screenHeight,currentSceneState);
  }
}

class GettingStartedContainerState extends State<GettingStartedContainer>
    with TickerProviderStateMixin {
  AnimationController animationController;

  ANIMATION_STATUS currentSceneState;

  AnimationController _expandAnimationController;

  Animation<double> _expandAnimation;

  final double INTIAL_CIRCULAR_REVELAR_RADIUS = 50;

   double screenHeight;

  GettingStartedContainerState(this.animationController, this.screenHeight,this.currentSceneState);

  Animation<double> _circularRevealAnimation;

  @override
  void initState() {
    super.initState();

    _circularRevealAnimation =
        Tween<double>(begin: INTIAL_CIRCULAR_REVELAR_RADIUS, end: 2*this.screenHeight+this.screenHeight)
            .animate(CurvedAnimation(parent: animationController,curve: Curves.easeInQuad));

    _circularRevealAnimation.addListener(() {
      this.currentSceneState=ANIMATION_STATUS.REVEALING;
      _expandAnimationController.stop();
    });

    _expandAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _expandAnimation = Tween<double>(
            begin: _circularRevealAnimation.value,
            end: _circularRevealAnimation.value * 1.2)
        .animate(CurvedAnimation(
            curve: Curves.elasticOut, parent: _expandAnimationController));

    _expandAnimationController.addListener(() {
      setState(() {});
    });

    if (currentSceneState == ANIMATION_STATUS.INITIAL) {
      _expandAnimationController.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    STATE state=(currentSceneState==ANIMATION_STATUS.INITIAL)?STATE.INITIAL:STATE.RESTING;
    if (currentSceneState != ANIMATION_STATUS.INITIAL)
      return Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: SwipeToReveal(animatedRadius: _circularRevealAnimation,state: state),
          ));
    else {
      Stack stack = Stack(
        children: <Widget>[
          AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, builder) {
                return Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: SwipeToReveal(animatedRadius: _expandAnimation,state: state),
                    ));
              }),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _circularRevealAnimation.value,
                width: _circularRevealAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    animationController.forward(from:animationController.value);
                  },
                ),
              ))
        ],
      );

      return stack;
//      return AnimatedBuilder(
//          animation: _expandAnimation,
//          builder: (context, builder) {
//            return Container(
//                height: double.infinity,
//                width: double.infinity,
//                child: CustomPaint(
//                  painter: SwipeToReveal(animatedRadius: _expandAnimation),
//                ));
//          });
    }
  }

  @override
  void dispose() {
    _expandAnimationController.dispose();
  }
}

enum ANIMATION_STATUS { INITIAL, REVEALING, FINISHED }
