import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';


class AnimatedTypedTextWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionTextState("The Earth is approximately how many miles away from the Sun?");
  }
}

class QuestionTextState extends State<AnimatedTypedTextWidget>
    with SingleTickerProviderStateMixin {
  String _question;

  AnimationController controller;

  Animation<double> animation;

  QuestionTextState(this._question);

  @override
  void initState() {
    super.initState();
    final int time=_question.length~/0.05*window.devicePixelRatio.toInt();
    controller =
        AnimationController(duration:  Duration(milliseconds: time), vsync: this);
//    controller.drive(
//        CurveTween(curve: Curves.easeOut));
    animation = Tween<double>(begin: 0 , end:1).animate(controller);
    controller.forward();


  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) =>
            Text(
                    _getAnimatedStringValue(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ),

    );
  }

  String _getAnimatedStringValue() {
    int index=(animation.value*_question.length).toInt();
    return _question.substring(0,index);
  }
}
