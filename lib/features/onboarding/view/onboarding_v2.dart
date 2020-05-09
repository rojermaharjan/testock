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

  Widget getLoginForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Let's Start",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,16,0,16),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,10),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Password cannot be empty';
//                          }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
                onPressed: () {
//                          Navigator.pushReplacement(
//                            context,
//                            MyCustomRoute(builder: (context) => TestScreen()),
//                          );
//                            if (_loginFormKey.currentState.validate()) {
//                              // Process data.
//                            }
                },
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black)),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lalezar',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade900),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,16,0,0),
            child: Text(
              "Don't have an account?",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,5,0),
            child: Text(
              "Register Here",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade500),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getOnBoardingRelatedScreens() {
    return <Widget>[
      GettingStartedContainer(_onBoardingToRegistrationSceneController,
          MediaQuery.of(context).size.height),
      Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Welcome To TestOck",
                style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.start,
              )
            ],
          )),
    ];
  }
}
