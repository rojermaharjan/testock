import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testockmbl/common/widget/swippable_arc_bg.dart';
import 'package:testockmbl/features/test/view/test_screen.dart';
import 'package:testockmbl/router.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingState();
  }
}

/**
 * The idea for this onboarding process is two break it into two scene.
 * 1) Intially the promo of app is shown as scene one.
 * 2) When user swipe from bottom, scene two is loaded with two tabs i.e (Login, Signup)
 */
class _OnBoardingState extends State<StatefulWidget>
    with TickerProviderStateMixin {
  AnimationController _onboardingAnimationSceneController;
  Animation _swippableCurveAnimation;
  double _swippableCurveFinalTopOffsetRelativeToScreen = .7;
  final double _swippableCurveInitialTopOffsetRelativeToScreen = .7;

  AnimationController _tabSelectedAnimationController;
  Animation<double> _tabSelectionAnimation;
  SELECTED_TAB _lastSelectedTab;
  SELECTED_TAB _requestedTabIndex;

  static final int ONBOARDING_SCENE_ANIM_DURATION = 350;

  static final double TAB_HEADER_HEIGHT = 185;
  static final double TAB_HEADER_OFFSET = 50;

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /**
     * TODO need to defer the position calculation and avoid during building widget process
     */
    double windowHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    double tabHeight = (MediaQuery.of(context).devicePixelRatio) *
        (TAB_HEADER_HEIGHT + TAB_HEADER_OFFSET);

//    _swippableCurveFinalTopOffsetRelativeToScreen =
//        (1 - (tabHeight) / windowHeight) - .15;

    _swippableCurveFinalTopOffsetRelativeToScreen =
        (tabHeight / windowHeight) + .03;

    _swippableCurveAnimation = Tween<double>(
            begin: 0, end: _swippableCurveFinalTopOffsetRelativeToScreen)
        .animate(CurvedAnimation(
            curve: Curves.easeOut,
            parent: _onboardingAnimationSceneController));

//    return _getJhonnyVinoOnBoardingScreen(context);

    return _getJhonnyVinoOnBoardingScreen(context);
  }

  @override
  void initState() {
    super.initState();

    _onboardingAnimationSceneController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: ONBOARDING_SCENE_ANIM_DURATION),
    );

    _requestedTabIndex = SELECTED_TAB.NONE;
    _lastSelectedTab = SELECTED_TAB.NONE;

    _tabSelectedAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });

    _tabSelectedAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _lastSelectedTab = _requestedTabIndex;
      }
    });

    _tabSelectionAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Curves.easeOut, parent: _tabSelectedAnimationController));
  }

  _onTabSelected(SELECTED_TAB selectedTabIndex) {
    if (this._requestedTabIndex != selectedTabIndex) {
      this._requestedTabIndex = selectedTabIndex;
      _tabSelectedAnimationController.forward(from: 0);
    }
  }

  Widget _getJhonnyVinoOnBoardingScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: backgroundDecoration,
            child: CustomPaint(
              painter: SwipableArc(
                  _swippableCurveAnimation,
                  _swippableCurveInitialTopOffsetRelativeToScreen,
                  _requestedTabIndex,
                  _lastSelectedTab,
                  _tabSelectionAnimation),
            )),
        _getTabHeaderView(),
        _getCurrentSelectedTabContent(),
      ],
    );
  }

  Widget getLoginForm() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height -
        TAB_HEADER_HEIGHT -
        TAB_HEADER_OFFSET;
    return Positioned(
        top: TAB_HEADER_HEIGHT + TAB_HEADER_OFFSET,
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your username',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MyCustomRoute(builder: (context) => TestScreen()),
                            );
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
                                color: Colors.black),
                          )),
                    ),
                  ],
                ),
              )),
        ));
  }

  Widget getRegisterForm() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height -
        TAB_HEADER_HEIGHT -
        TAB_HEADER_OFFSET;
    return Positioned(
        top: TAB_HEADER_HEIGHT + TAB_HEADER_OFFSET,
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your username',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your mobile',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mobile cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: FlatButton(
                          onPressed: () {
                            if (_loginFormKey.currentState.validate()) {
                              // Process data.
                            }
                          },
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.black)),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Lalezar',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          )),
                    ),
                  ],
                ),
              )),
        ));
  }

  void onLoginBtnPressed() {}

  void onRegisterBtnPressed() {}

  /**
   * Load second scene and pre-select tab first
   */
  void _startTransitionFromFirstScene() {
    _onboardingAnimationSceneController.addListener(() {
      setState(() {});
    });

    _onboardingAnimationSceneController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onboardingAnimationSceneController.removeStatusListener(null);
        _onboardingAnimationSceneController.removeListener(null);
        _onTabSelected(SELECTED_TAB.LEFT);
      }
    });
    _onboardingAnimationSceneController.forward(from: 0);
  }

  Widget _getTabHeaderView() {
    return AnimatedBuilder(
      animation: _onboardingAnimationSceneController,
      builder: (context, builder) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _createTab("Login", () => _onTabSelected(SELECTED_TAB.LEFT),
                Colors.orange),
            _createTab("Signup", () => _onTabSelected(SELECTED_TAB.RIGHT),
                Colors.green),
          ],
        );
      },
    );
  }

  _createTab(String tabName, VoidCallback onTabCallback, Color color) {
    return Expanded(
      child: Container(
        height: TAB_HEADER_HEIGHT,
        child: InkWell(
          onTap: () {
            onTabCallback();
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Opacity(
                    opacity: _onboardingAnimationSceneController.value,
                    child: Text(
                      tabName,
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Lalezar',
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ))),
          ),
        ),
      ),
    );
  }

  _getCurrentSelectedTabContent() {
    if (_requestedTabIndex == SELECTED_TAB.RIGHT) {
      return getRegisterForm();
    } else if (_requestedTabIndex == SELECTED_TAB.LEFT) {
      return getLoginForm();
    } else {
      return AnimatedBuilder(
          animation: _onboardingAnimationSceneController,
          builder: (c, b) {
            return Opacity(
              opacity:
                  ReverseAnimation(_onboardingAnimationSceneController).value,
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
                          child: Text(
                            'Some promo goes here!!',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Lalezar',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FlatButton(
                              onPressed: this._startTransitionFromFirstScene,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black)),
                              child: Text(
                                'Start your Journey',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Lalezar',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ))))
                ],
              ),
            );
          });
    }
  }


//  Widget _getScrollableContent() {
//    return Stack(
//      children: <Widget>[
//        Container(
//            height: double.infinity,
//            width: double.infinity,
//            decoration: backgroundDecoration,
//            child: CustomPaint(
//              painter: SwipableArc(
//                  _swippableCurveAnimation,
//                  _swippableCurveInitialTopOffsetRelativeToScreen,
//                  _requestedTabIndex,
//                  _lastSelectedTab,
//                  _tabSelectionAnimation),
//            )),
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            _getTabHeaderView(),
//            Expanded(
//              flex:1,
//              child:SingleChildScrollView(
//                child:
//                Expanded(
//                child:
//                )
//
//              )
//            )
//          ],
//        )
//      ],
//    );
//  }
}

Widget getContainerDummy(double height, double width, Color bgColor) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(color: bgColor),
  );
}

const backgroundDecoration = BoxDecoration(
  color: Color.fromRGBO(55, 81, 126, 1),
//    color: Color.fromRGBO(72, 32, 232, 1)
);
