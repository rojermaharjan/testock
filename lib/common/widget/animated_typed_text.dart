import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';


class AnimatedTypedText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionTextState("What is a quote that inspires you?");
  }
}

class QuestionTextState extends State<AnimatedTypedText>
    with SingleTickerProviderStateMixin {
  String _question;

  AnimationController controller;

  Animation<int> animation;

  QuestionTextState(this._question);

  @override
  void initState() {
    super.initState();
    final int time=_question.length~/0.1;
    controller =
        AnimationController(duration:  Duration(milliseconds: time), vsync: this);
    controller.drive(
        CurveTween(curve: Curves.easeInOutCubic));
    animation = IntTween(begin: 0 , end:_question.length).animate(controller);
    controller.forward();


  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) =>
            Text(
                    _getAnimatedStringValue(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ),

    );
  }

  String _getAnimatedStringValue() {

    return _question.substring(0,animation.value);
  }
}
