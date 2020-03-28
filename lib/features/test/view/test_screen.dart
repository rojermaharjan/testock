import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testockmbl/common/widget/animated_outline_button.dart';
import 'package:testockmbl/common/widget/animated_typed_text.dart';
import 'package:testockmbl/features/test/model/question_models.dart';
import 'package:testockmbl/features/test/presenter/test_screen_presenter.dart';
import 'package:testockmbl/features/test/view/test_summary_screen.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestScreenState();
  }
}

class _TestScreenState extends State<StatefulWidget>
    with TickerProviderStateMixin {
  QuestionEvent currentState;

  bool isSummaryDialogRenderedCompletely;

  AnimationController _controller;
  Animation _offsetAnimation;

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
        return

              SlideTransition(
              position: _offsetAnimation,
              child:
              Container(
                  color: Colors.cyan,
                  width: 200,
                  child:Text("Something"))
          );

//        return Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text(
//                    "Do you want to play again?",
//                    style: TextStyle(
//                        fontSize: 37,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.white),
//                    textAlign: TextAlign.center,
//                  ),
//                  Padding(
//                      padding: EdgeInsets.all(14.0),
//                      child: FlatButton(
//                          color: Colors.transparent,
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(30),
//                              side: BorderSide(color: Colors.grey.shade200)),
//                          onPressed: () => GetIt.I<TestScreenPresenter>()
//                              .queryNextQuestion(),
//                          child: Text(
//                            'Lets go',
//                            style: TextStyle(
//                                fontSize: 17,
//                                fontFamily: 'Lalezar',
//                                fontWeight: FontWeight.w400,
//                                color: Colors.white),
//                          )))
//                ]
//          );
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
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 3)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    GetIt.I.registerSingleton<TestScreenPresenter>(TestScreenPresenter());
    GetIt.I<TestScreenPresenter>().questionEventStream.listen((event) {
      this.currentState = event;
      setState(() {});
    });

    GetIt.I<TestScreenPresenter>().summaryEventStream.listen((summary) {
      _showSummaryScreen(summary);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    GetIt.I.unregister<TestScreenPresenter>();
  }

  void _showSummaryScreen(Summary summary) {
    isSummaryDialogRenderedCompletely = false;
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6),
      // background color
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return TestSummary(
            summaryDetail: summary,
            onSummaryReviewed: () {
              GetIt.I<TestScreenPresenter>().onSummaryReviewd();
            });
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      barrierDismissible: false,
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
