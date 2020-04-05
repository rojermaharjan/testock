import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SingInState();
  }
}

class _SingInState extends State<StatefulWidget> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0);

    return Positioned.fill(
        child: Align(
            alignment: Alignment.center,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: _getSignUpScreenWidget(),
            )));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _scaleAnimation = Tween<double>(begin: .3, end: 1.0).animate(
        CurvedAnimation(
            curve: Curves.elasticOut, parent: _animationController));

    setState(() {});
  }

  _getSignUpScreenWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Do you want to play again?",
            style: TextStyle(
                fontSize: 37, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Padding(
              padding: EdgeInsets.all(14.0),
              child: FlatButton(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.grey.shade200)),
                  child: Text(
                    'Lets go',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Lalezar',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )))
        ]);
  }
}

