import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:testockmbl/base/base_events.dart';
import 'package:testockmbl/features/test/model/question_models.dart';

class TestScreenPresenter {
  BaseBehaviorBloc<Question> _questionBloc;
  BaseBehaviorBloc<QuestionEvent> _questionEventBloc;
  PublishSubject<AnswerEvent> _answerEventBloc;

  List<Question> _questionList;

  int _questionIndex;

  int _feedbackQuestionIndex;

  bool _hasProvidedFeedback;

  TestScreenPresenter() {
    _questionList = getDummyQuestions();
    _questionIndex = 0;
    _questionBloc =
        new BaseBehaviorBloc.withInitialData(_questionList[_questionIndex]);
    _questionEventBloc = new BaseBehaviorBloc.withInitialData(
        QuestionEvent.NEW_QUESTION_ARRIVED);
    _answerEventBloc = new PublishSubject();

    _performDefaultAction();
  }

  void _performDefaultAction() {
    //TODO update the resepective flag accrodign the chose
    _feedbackQuestionIndex = 6;
    _hasProvidedFeedback = false;
  }

  Question getCurrentQuestion() {
    return _questionBloc.getCurrentState();
  }

  String getCurrentQuestionIndex() {
    if (!_hasProvidedFeedback)
      return (_questionIndex + 1).toString() +
          "/" +
          _questionList.length.toString();
    else
      return (_questionIndex + 1).toString() +
          "/" +
          _feedbackQuestionIndex.toString();
  }

  queryNextQuestion() {
    _questionIndex++;
    print("Queried next question: $_hasProvidedFeedback $_questionIndex");
    //Has already provided feedback
    if (_hasProvidedFeedback) {
      //Provided feedback but replaying quiz
      if (_questionIndex < _feedbackQuestionIndex) {
        _questionBloc.updateState(_questionList[_questionIndex]);
        _questionEventBloc.updateState(QuestionEvent.NEW_QUESTION_ARRIVED);
      } else {
        //Replaying quiz but avoid feedback question form second time
        restartTest();
      }
    }
    //Not provided feedback
    else {
      //Allow to play quiz till end of the question list
      if (_questionIndex < _questionList.length) {
        _questionBloc.updateState(_questionList[_questionIndex]);
        _questionEventBloc.updateState(QuestionEvent.NEW_QUESTION_ARRIVED);
      } else {
        //In the end after playing quiz, prompt feedback
        _questionEventBloc.updateState(QuestionEvent.PROMPT_FEEDBACK);
      }
    }
  }

  restartTest() {
    _questionList.forEach((element) {
      element.answerOptions.forEach((element) {
        element.isSelectedByUser = false;
      });
    });
    _questionIndex = -1;

    _questionEventBloc.updateState(QuestionEvent.END_OF_QUESTION);
  }

  postFeedback() {
    new Future.delayed(Duration(milliseconds: 500), () {
      _hasProvidedFeedback = true;
      restartTest();
    });
  }

  Stream<QuestionEvent> get questionEventStream =>
      _questionEventBloc.getStream();

  Stream<AnswerEvent> get answerEventStream => _answerEventBloc.stream;

  void onAnswerSelected(int position) {
    AnswerOption selectedAnswer =
        _questionBloc.getCurrentState().answerOptions[position];
    selectedAnswer.isSelectedByUser = true;

    if (_questionBloc.getCurrentState().isQuestionOpinion)
      _answerEventBloc.sink.add(AnswerEvent.OPINION);
    else if (selectedAnswer.isSelectedByUser && selectedAnswer.isCorrect)
      _answerEventBloc.sink.add(AnswerEvent.RIGHT_ANSWER_SELECTED);
    else
      _answerEventBloc.sink.add(AnswerEvent.WRONG_ANSWER_SELECTED);
  }
}

enum QuestionEvent {
  NEW_QUESTION_ARRIVED,
  LOADING,
  END_OF_QUESTION,
  PROMPT_FEEDBACK
}

enum AnswerEvent { WRONG_ANSWER_SELECTED, RIGHT_ANSWER_SELECTED, OPINION }
