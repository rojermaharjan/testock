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
   double _swippableCurveFinalTopOffsetRelativeToScreen = .7;
  final double _swippableCurveInitialTopOffsetRelativeToScreen = .9;

  AnimationController _tabSelectedAnimationController;
  Animation<double> _tabSelectionAnimation;
  SELECTED_TAB _lastSelectedTab;
  SELECTED_TAB _requestedTabIndex;


  static final int ONBOARDING_SCENE_ANIM_DURATION = 800;

  static final double TAB_HEADER_HEIGHT=90;



  @override
  Widget build(BuildContext context) {
    double windowHeight=MediaQuery.of(context).size.height*MediaQuery.of(context).devicePixelRatio;
    double tabHeight=(MediaQuery.of(context).devicePixelRatio)*TAB_HEADER_HEIGHT;

    _swippableCurveFinalTopOffsetRelativeToScreen=(1-(tabHeight)/windowHeight)-.15;
        print("Final offset value : $_swippableCurveFinalTopOffsetRelativeToScreen");

    _swippableCurveAnimation = Tween<double>(
        begin: 0, end: _swippableCurveFinalTopOffsetRelativeToScreen)
        .animate(CurvedAnimation(
        curve: Curves.easeOutCirc,
        parent: _onboardingAnimationSceneController));
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
        child:
        InkWell(
          onTap: (){onTabCallback();},
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
