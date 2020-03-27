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
                    ))),
            Positioned(
                child: Align(
                    alignment: FractionalOffset(.5, .2),
                    child: AnimatedTypedText(key: UniqueKey()))),
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
                child: Text(
                  "Do you want to play again?",
                  style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(14.0),
                  child: FlatButton(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.grey.shade200)),
                      onPressed: () =>
                          GetIt.I<TestScreenPresenter>().queryNextQuestion(),
                      child: Text(
                        'Lets go',
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Lalezar',
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )))
            ]);
        break;

      case QuestionEvent.PROMPT_FEEDBACK:
        return Stack(
          children: <Widget>[
            Positioned(
                child: Align(
                    alignment: FractionalOffset(.5, .4),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Your valuable feedback is appreciated",
                            style: TextStyle(
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          TextField(
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                              padding: EdgeInsets.all(14.0),
                              child: FlatButton(
                                  onPressed: () =>
                                      GetIt.I<TestScreenPresenter>()
                                          .postFeedback(),
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: Colors.grey.shade200)),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Lalezar',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )))
                        ])))
          ],
        );
        break;
    }
  }

  @override
  void initState() {
    GetIt.I.registerSingleton<TestScreenPresenter>(TestScreenPresenter());
    GetIt.I<TestScreenPresenter>().questionEventStream.listen((event) {
      this.currentState = event;
      setState(() {
        _animationController.forward(from: 0);
      });
    });

    GetIt.I<TestScreenPresenter>().summaryEventStream.listen((event) {
      _showSummaryScreen();
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

  void _showSummaryScreen() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // background color
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Wrap(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.orange,
            ),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
    );
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
