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

  Color _buttonBorderColor;

  _AnimatedOutlineButtonState(int position) {
    this._position = position;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: FlatButton(
                    color: _animation.value % 2 == 0
                        ? Colors.transparent
                        : _buttonAnimatingColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: _buttonBorderColor)),
                    onPressed: onAnswerSelected,
                    child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          _currentAnswer.answer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: _animation.value % 2 == 0
                                  ? Colors.grey.shade700
                                  : Colors.white),
                        )))),
          );
        });
  }

  @override
  void initState() {
    this._presenter = GetIt.I<TestScreenPresenter>();
    getLatestState();

    _buttonBorderColor = Colors.grey.shade400;

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
        this._buttonBorderColor = this._buttonAnimatingColor;
        if (this._currentAnswer.isCorrect &&
            !this._currentAnswer.isSelectedByUser)
          _controller.forward(from: 0);
        else if (this._currentAnswer.isSelectedByUser)
          _controller.forward(from: _maxAnimationCount.toDouble());
      }

      if (event == AnswerEvent.RIGHT_ANSWER_SELECTED) {
        if (this._currentAnswer.isCorrect) {
          this._buttonBorderColor = this._buttonAnimatingColor;
          _controller.forward(from: _maxAnimationCount.toDouble());
        }
      }
    });
  }

  void onAnswerSelected() {
    this._currentAnswer = _currentQuestion.answerOptions[_position];
    _presenter.onAnswerSelected(_position);
    int duration=500;
    if (!this._currentQuestion.isQuestionOpinion)
     duration=1100;


    new Future.delayed(
         Duration(milliseconds: duration), _presenter.queryNextQuestion);
  }

  void getLatestState() {
    this._currentQuestion = _presenter.getCurrentQuestion();
    this._currentAnswer = _currentQuestion.answerOptions[_position];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
