import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:testockmbl/features/test/model/question_models.dart';
import 'package:testockmbl/features/test/presenter/test_screen_presenter.dart';

class AnimatedTypedText extends StatefulWidget {
  AnimatedTypedText({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionTextState();
  }
}

class QuestionTextState extends State<AnimatedTypedText>
    with SingleTickerProviderStateMixin {
  Question _questionModel;

  AnimationController _controller;

  Animation<int> _animation;


  QuestionTextState();

  List<String> _questionWordList;

  @override
  void initState() {
    super.initState();


    _questionModel = GetIt.I<TestScreenPresenter>().getCurrentQuestion();

    _questionWordList = _questionModel.question.split(" ");
    final int time = _questionWordList.length ~/ 0.012;
    _controller = AnimationController(
        duration: Duration(milliseconds: time), vsync: this);
    _controller.drive(CurveTween(curve: Curves.easeInOutQuad));
    _animation =
        IntTween(begin: 0, end: _questionWordList.length).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) =>
               Opacity(
                opacity: _animation.value / _questionWordList.length ,
                child: Text(
                  _getAnimatedStringValue(),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getAnimatedStringValue() {
    String _animQuestion = "";
    String trail = " ";
    for (int i = 0; i < _animation.value; i++) {
      _animQuestion += _questionWordList[i] + trail;
    }
    return _animQuestion;
  }
}
