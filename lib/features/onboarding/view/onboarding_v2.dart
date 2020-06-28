import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:testockmbl/features/onboarding/view/getting_started_bg.dart';
import 'package:testockmbl/features/registration/view/registration_screen.dart';

class OnBoardingV2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnBoardingV2State();
  }
}

class OnBoardingV2State extends State<OnBoardingV2>
    with TickerProviderStateMixin {
  AnimationController _onBoardingToRegistrationSceneController;

  AnimationController _titleFadeInAnimationController;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getAppropriateScenes(),
    );
  }

  List<Widget> _getAppropriateScenes() {
    if (_onBoardingToRegistrationSceneController.status ==
        AnimationStatus.completed)
      return getRegistrationRelatedScreens();
    else
      return getOnBoardingRelatedScreens();
  }

  @override
  void initState() {
    super.initState();
    initOnBoradingToRegistrationScene();
    _titleFadeInAnimationController.forward(from: 0);
  }

  @override
  void dispose() {
    _onBoardingToRegistrationSceneController.dispose();
    _titleFadeInAnimationController.dispose();
    super.dispose();
  }

  void initOnBoradingToRegistrationScene() {
    _onBoardingToRegistrationSceneController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _titleFadeInAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));



    _onBoardingToRegistrationSceneController.addListener(() {
      setState(() {});
    });


    _titleFadeInAnimationController.addListener(() {
      setState(() {});
    });

  }

  List<Widget> getRegistrationRelatedScreens() {
    return <Widget>[
      GettingStartedContainer(_onBoardingToRegistrationSceneController,
          MediaQuery.of(context).size.height,ANIMATION_STATUS.FINISHED),
      Align(
        alignment: Alignment.center,
        child: RegistrationScreen(),
      )
    ];
  }

  List<Widget> getOnBoardingRelatedScreens() {
    return <Widget>[


      Container(
          decoration: blackRadialDecoration,
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0,40,20,20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FadeTransition(
                  opacity: _titleFadeInAnimationController.drive(CurveTween(curve: Curves.easeOut)),
                  child: Text(
                    "TestOck",
                    style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
                FadeTransition(
                  opacity: _titleFadeInAnimationController.drive(CurveTween(curve: Curves.easeOut)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,8,0,0),
                    child: Text(
                      "Your learning companion",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              ],
            ),
          )),
      FlareActor(
          "assets/animation/star_bg.flr",
          alignment: Alignment.topCenter,
          animation: "stars"
      ),

      GettingStartedContainer(_onBoardingToRegistrationSceneController,
          MediaQuery.of(context).size.height,ANIMATION_STATUS.INITIAL),

//      Container(
//        height: double.infinity,
//        width: double.infinity,
//        child: Rive  (
//          filename: "assets/animation/glowing_sun.flr",
//          animation: "Sun_idle",
//        ),
//      ),

    ];
  }
}

//const blackRadialDecoration = BoxDecoration(
//  gradient: RadialGradient(
//    radius: 1,
//    center: Alignment.topRight,
//    colors: [
////      Color.fromRGBO(55, 81, 126, 1),
////      Color.fromRGBO(232, 148, 173, 1),
//
////      Color.fromRGBO(242, 204, 143, 1),
////      Color.fromRGBO(244, 172, 183, 1),
//      Colors.black,
//      Color.fromRGBO( 26, 26, 26,.6),
//
//
//    ],
//
//  ),
//);

const blackRadialDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
//      Color.fromRGBO(55, 81, 126, 1),
//      Color.fromRGBO(232, 148, 173, 1),

//      Color.fromRGBO(242, 204, 143, 1),
//      Color.fromRGBO(244, 172, 183, 1),

      Colors.black,
      Colors.transparent,
//      Color.fromRGBO( 26, 26, 26,.6),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);

