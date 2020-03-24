import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testockmbl/common/widget/animated_outline_button.dart';
import 'package:testockmbl/common/widget/animated_typed_text.dart';
import 'package:testockmbl/features/test/presenter/test_screen_presenter.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestScreenState();
  }
}

class _TestScreenState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  QuestionEvent currentState;

  AnimationController _animationController;

  Animation _animation;

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case QuestionEvent.LOADING:
        return Center(
          child: Text("Loading"),
        );
        break;
      case QuestionEvent.NEW_QUESTION_ARRIVED:
        return Stack(
          children: <Widget>[
            Positioned(
                child: Align(
                    alignment: FractionalOffset(.5, .07),
                    child: Text(
                      GetIt.I<TestScreenPresenter>().getCurrentQuestionIndex(),
                      style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                )
            )
            ,
            Positioned(
                child: Align(
                    alignment: FractionalOffset(.5, .2),
                    child: AnimatedTypedText(key: UniqueKey())
                )
            )
            ,
            Positioned(
                child: Align(
                    alignment: FractionalOffset(.5, 1),
                    child: _getAnswerOptionWidget()))
          ],
        );

      case QuestionEvent.END_OF_QUESTION:
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Do you want to play again?"),
              ),
              FlatButton(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.grey.shade200)),
                  onPressed: GetIt
                      .I<TestScreenPresenter>()
                      .queryNextQuestion,
                  child: Text(
                    'Click Me',
                    style: TextStyle(
                        fontFamily: 'Lalezar',
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ))
            ]);
        break;
    }
  }

  @override
  void initState() {
    GetIt.I.registerSingleton<TestScreenPresenter>(TestScreenPresenter());
    GetIt
        .I<TestScreenPresenter>()
        .questionEventStream
        .listen((event) {
      this.currentState = event;
      setState(() {
        _animationController.forward(from: 0);
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animationController.drive(CurveTween(curve: Curves.linear));

    _animation = Tween(
      begin: 1.7,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    GetIt.I.unregister<TestScreenPresenter>();
    _animationController.dispose();
    super.dispose();
  }

  _getAnswerOptionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedOutlineButton(key: UniqueKey(), position: 0),
        AnimatedOutlineButton(key: UniqueKey(), position: 1),
        AnimatedOutlineButton(key: UniqueKey(), position: 2),
        AnimatedOutlineButton(key: UniqueKey(), position: 3),
      ],
    );
  }




}

