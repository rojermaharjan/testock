import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:testockmbl/common/widget/CustomOutlineButtonWidget.dart';

class AnimatedOutlineButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimatedOutlineButtonState();
  }
}

class _AnimatedOutlineButtonState extends State<AnimatedOutlineButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<int> _animation;

  bool  _shouldSopAnimation=false ;

  static final int _maxAnimationCount=10;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FlatButton(
              color:
                  _animation.value % 2 == 0 ? Colors.transparent : Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.grey)
              ),
              onPressed: _startAnimation,
              child: Text(
                'Click Me',
                style: TextStyle(
                    fontFamily: 'Lalezar',
                    fontWeight: FontWeight.w400,
                    color:  _animation.value % 2 == 0 ? Colors.black : Colors.white),
              ));
        });
  }

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 1800), vsync: this);
    _controller.drive(CurveTween(curve: Curves.bounceOut));
    _animation = IntTween(begin: 0, end: _maxAnimationCount).animate(_controller)..addListener(() {
      if(_animation.value==_maxAnimationCount)
          _shouldSopAnimation=true;
      if (_shouldSopAnimation ) {
        _controller.reset();
        _shouldSopAnimation = false;

      }
    });
  }

  void _startAnimation() {
    _controller.forward(from: 0);
  }
}
