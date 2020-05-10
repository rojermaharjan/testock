import 'package:flutter/material.dart';
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
  }


  @override
  void dispose() {
    _onBoardingToRegistrationSceneController.dispose();
    super.dispose();
  }

  void initOnBoradingToRegistrationScene() {
    _onBoardingToRegistrationSceneController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _onBoardingToRegistrationSceneController.addListener(() {
      setState(() {});
    });
  }

  List<Widget> getRegistrationRelatedScreens() {
    return <Widget>[
      GettingStartedContainer(_onBoardingToRegistrationSceneController,
          MediaQuery.of(context).size.height),
      Align(
        alignment: Alignment.center,
        child: RegistrationScreen(),
      )
    ];
  }


  List<Widget> getOnBoardingRelatedScreens() {
    return <Widget>[

      Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "TestOck",
                  style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Your learning companion",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          )),
      GettingStartedContainer(_onBoardingToRegistrationSceneController,
          MediaQuery.of(context).size.height),
    ];
  }
}
