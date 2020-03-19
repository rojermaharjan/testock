import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:testockmbl/common/widget/custom_outline_button_widget.dart';

class AnimatedOutlineButton extends StatefulWidget {
   AnimatedOutlineButton({Key key}) :super(key: key);

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

  static final int _maxAnimationCount = 5;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FlatButton(
              color:
              _animation.value % 2 == 0 ? Colors.transparent : Colors.green.shade700
                 ,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: _controller.isAnimating?Colors.green.shade700:Colors.grey.shade200)
              ),
              onPressed: _startAnimation,
              child: Text(
                'Click Me',
                style: TextStyle(
                    fontFamily: 'Lalezar',
                    fontWeight: FontWeight.w400,
                    color: _animation.value % 2 == 0 ? Colors.black : Colors
                        .white),
              ));
        });
  }

  @override
  void initState() {
    _controller =
        AnimationController(
            duration: Duration(milliseconds: 800), vsync: this);
    _controller.drive(CurveTween(curve: Curves.decelerate));
    _animation =
    IntTween(begin: 0, end: _maxAnimationCount).animate(_controller)
      ..addListener(() {
      if (_animation.value ==_maxAnimationCount)
        _controller.stop();
    }


  );
}

void _startAnimation() {
  _controller.forward(from: 0);
}}
