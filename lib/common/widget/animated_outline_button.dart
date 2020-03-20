import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:get_it/get_it.dart';
import 'package:testockmbl/common/widget/custom_outline_button_widget.dart';
import 'package:testockmbl/features/test/model/question_models.dart';
import 'package:testockmbl/features/test/presenter/test_screen_presenter.dart';

class AnimatedOutlineButton extends StatefulWidget {
  int _position;

  AnimatedOutlineButton({Key key, int position}) : super(key: key) {
    this._position = position;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimatedOutlineButtonState(_position);
  }
}

class _AnimatedOutlineButtonState extends State<AnimatedOutlineButton>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<int> _animation;

  static final int _maxAnimationCount = 5;

  TestScreenPresenter _presenter;

  int _position;

  AnswerOption _currentAnswer;

  Color _buttonAnimatingColor;

  Question _currentQuestion;

  bool _disableClick;

  _AnimatedOutlineButtonState(int position) {
    this._position = position;
    this._disableClick=false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FlatButton(
              color: _animation.value % 2 == 0
                  ? Colors.transparent
                  : _buttonAnimatingColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                      color: _controller.isAnimating
                          ? _buttonAnimatingColor
                          : Colors.grey.shade200)),
              onPressed: onAnswerSelected,
              child: Text(
                _currentAnswer.answer,
                style: TextStyle(
                    fontFamily: 'Lalezar',
                    fontWeight: FontWeight.w400,
                    color: _animation.value % 2 == 0
                        ? Colors.black
                        : Colors.white),
              ));
        });
  }

  @override
  void initState() {
    this._presenter = GetIt.I<TestScreenPresenter>();
    getLatestState();

    if (_currentAnswer.isCorrect)
      _buttonAnimatingColor = Colors.green.shade700;
    else
      _buttonAnimatingColor = Colors.red.shade700;

    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _controller.drive(CurveTween(curve: Curves.decelerate));
    _animation =
        IntTween(begin: 0, end: _maxAnimationCount).animate(_controller)
          ..addListener(() {
            if (_animation.value == _maxAnimationCount) {
              _controller.stop();
            }
          });

    _presenter.answerEventStream.listen((event) {

      if (event == AnswerEvent.WRONG_ANSWER_SELECTED) {
        if(this._currentAnswer.isCorrect&&!this._currentAnswer.isSelectedByUser)
          _controller.forward(from: 0);
        else if(this._currentAnswer.isSelectedByUser)
          _controller.forward(from: _maxAnimationCount.toDouble());
      }

      if (event == AnswerEvent.RIGHT_ANSWER_SELECTED) {
        if(this._currentAnswer.isCorrect)
        _controller.forward(from: _maxAnimationCount.toDouble());
      }


    });
  }

  void onAnswerSelected() {
    if(!this._disableClick) {
      this._disableClick = true;
      this._currentAnswer = _currentQuestion.answerOptions[_position];
      _presenter.onAnswerSelected(_position);
      new Future.delayed(
          const Duration(milliseconds: 800), _presenter.queryNextQuestion);
    }
  }

  void getLatestState() {
    this._currentQuestion = _presenter.getCurrentQuestion();
    this._currentAnswer = _currentQuestion.answerOptions[_position];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
