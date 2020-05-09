import 'package:testockmbl/common/widget/swipe_to_reveal.dart';

import 'package:flutter/widgets.dart';

class GettingStartedContainer extends StatefulWidget {
  final AnimationController animationController;

  final double _screenHeight;

  GettingStartedContainer(this.animationController,this._screenHeight);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GettingStartedContainerState(animationController,_screenHeight);
  }
}

class GettingStartedContainerState extends State<GettingStartedContainer>
    with TickerProviderStateMixin {
  AnimationController animationController;

  ANIMATION_STATUS currentSceneState;

  AnimationController _expandAnimationController;

  Animation<double> _expandAnimation;

  final double INTIAL_CIRCULAR_REVELAR_RADIUS = 35;

   double screenHeight;

  GettingStartedContainerState(this.animationController, this.screenHeight){
    this.screenHeight=.2*this.screenHeight+this.screenHeight;
  }

  Animation<double> _circularRevealAnimation;

  @override
  void initState() {
    super.initState();

    this.currentSceneState = ANIMATION_STATUS.IDLE;
    _circularRevealAnimation =
        Tween<double>(begin: INTIAL_CIRCULAR_REVELAR_RADIUS, end: screenHeight)
            .animate(animationController);

    _circularRevealAnimation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          this.currentSceneState = ANIMATION_STATUS.PLAYING;
          break;

        case AnimationStatus.completed:
          this.currentSceneState = ANIMATION_STATUS.FINISHED;
          break;

        default:
          this.currentSceneState = ANIMATION_STATUS.IDLE;
          break;
      }
      _expandAnimationController.stop();
    });

    _expandAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _expandAnimation = Tween<double>(
            begin: _circularRevealAnimation.value,
            end: _circularRevealAnimation.value * 1.2)
        .animate(CurvedAnimation(
            curve: Curves.easeInOut, parent: _expandAnimationController));

    _expandAnimationController.addListener(() {
      setState(() {});
    });

    if (currentSceneState == ANIMATION_STATUS.IDLE) {
      _expandAnimationController.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentSceneState != ANIMATION_STATUS.IDLE)
      return Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: SwipeToReveal(animatedRadius: _circularRevealAnimation),
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
                      painter: SwipeToReveal(animatedRadius: _expandAnimation),
                    ));
              }),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _circularRevealAnimation.value,
                width: _circularRevealAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    animationController.forward();
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

enum ANIMATION_STATUS { IDLE, PLAYING, FINISHED }
