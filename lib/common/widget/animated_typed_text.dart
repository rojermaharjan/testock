import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:testockmbl/features/test/model/question_models.dart';
import 'package:testockmbl/features/test/presenter/test_screen_presenter.dart';


class AnimatedTypedText extends StatefulWidget {
  AnimatedTypedText({Key key}  ) :super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionTextState();
  }
}

class QuestionTextState extends State<AnimatedTypedText>
    with SingleTickerProviderStateMixin {

  Question _questionModel;

  AnimationController controller;

  Animation<int> animation;

  QuestionTextState();

  @override
  void initState() {
    super.initState();
    _questionModel =  GetIt.I<TestScreenPresenter>().getCurrentQuestion();
    final int time=_questionModel.question.length~/0.03;
    controller =
        AnimationController(duration:  Duration(milliseconds: time), vsync: this);
    controller.drive(
        CurveTween(curve: Curves.easeInOutCubic));
    animation = IntTween(begin: 0 , end:_questionModel.question.length).animate(controller);
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

    return _questionModel.question.substring(0,animation.value);
  }
}
