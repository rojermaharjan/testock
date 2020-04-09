import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testockmbl/common/widget/swippable_arc_bg.dart';

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
  final double _swippableCurveTopOffsetRelativeToScreen = .6;

  AnimationController _tabSelectedAnimationController;
  Animation<double> _tabSelectionAnimation;
  SELECTED_TAB _lastSelectedTab;
  SELECTED_TAB _requestedTabIndex;

  static final int ONBOARDING_SCENE_ANIM_DURATION=1400;

  @override
  Widget build(BuildContext context) {
    return _getJhonnyVinoOnBoardingScreen();
  }

  @override
  void initState() {
    super.initState();

    _onboardingAnimationSceneController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: ONBOARDING_SCENE_ANIM_DURATION),
    );
    _swippableCurveAnimation =
        Tween<double>(begin: 0, end: _swippableCurveTopOffsetRelativeToScreen)
            .animate(CurvedAnimation(
                curve: Curves.elasticOut,
                parent: _onboardingAnimationSceneController));

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

  Widget _getJhonnyVinoOnBoardingScreen() {
    return Stack(
      children: <Widget>[
        Container(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: SwipableArc(_swippableCurveAnimation, _requestedTabIndex,
                  _lastSelectedTab, _tabSelectionAnimation),
            )),
        _getHeaderLoginRegisterView(),
        _getCurrentSelectedTabContent(),
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
                      'Swipe',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Lalezar',
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )))),
      ],
    );
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

  Widget _getHeaderLoginRegisterView() {
    return AnimatedBuilder(
      animation: _onboardingAnimationSceneController,
      builder: (context, builder) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _onTabSelected(SELECTED_TAB.LEFT),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: Opacity(
                        opacity: _onboardingAnimationSceneController.value,
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
              onTap: () => _onTabSelected(SELECTED_TAB.RIGHT),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: Opacity(
                        opacity: _onboardingAnimationSceneController.value,
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

  _getCurrentSelectedTabContent() {
    String selectedTab = "";
    if (_requestedTabIndex == SELECTED_TAB.RIGHT) {
      selectedTab = "REGISTER";
    } else if (_requestedTabIndex == SELECTED_TAB.LEFT) {
      selectedTab = "LOGIN";
    } else {
      selectedTab = "ONBOARDING";
    }
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Text(
            selectedTab,
            style: TextStyle(
                fontSize: 13,
                fontFamily: 'Lalezar',
                fontWeight: FontWeight.w800,
                color: Colors.black),
          )),
    );
  }
}
