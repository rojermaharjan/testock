

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_models.g.dart';

@JsonSerializable()
class Question
{
  Question({this.questionId,this.question, this.options,this.isOpinion});
  String questionId;
  String question;
  List<Options> options;

  bool isOpinion;

  @override
  String toString() {
    return 'Question{question: $question, answerOptions: $options, isQuestionOpinion: $isOpinion}';
  }

  factory Question.fromJson(Map<String,dynamic> json)=>_$QuestionFromJson(json);

  Map<String,dynamic> toJson()=>_$QuestionToJson(this);

}

@JsonSerializable()
class Options
{

  Options({this.option, this.optionId, this.isCorrect,this.isSelectedByUser});

  String option;
  num optionId;
  bool isCorrect;
  bool isSelectedByUser;

  @override
  String toString() {
    return 'AnswerOption{answer: $option, id: $optionId, isCorrect: $isCorrect, isSelectedByUser: $isSelectedByUser}';
  }

  factory Options.fromJson(Map<String,dynamic> json)=>_$OptionsFromJson(json);

  Map<String,dynamic> toJson()=>_$OptionsToJson(this);

}

class Summary
{
  int totalQuestions;
  int correctAnswers;
  int incorrectAnswers;

  Summary({@required this.totalQuestions,@required this.correctAnswers, @required this.incorrectAnswers});

  static Summary createFrom(List<Question> questionList, int feedbackQuestionIndex) {
    int totalQuestion=feedbackQuestionIndex>0?feedbackQuestionIndex:questionList.length-1;
    int correctAnswers=0;
    int incorrectAnswers=0;

    for(int i=0;i<feedbackQuestionIndex;i++)
      {
        Question question=questionList[i];
        for(Options ans in question.options)
          {
            if(ans.isSelectedByUser)
              {
                print(ans);
                if(ans.isCorrect)
                  correctAnswers+=1;
                else
                  incorrectAnswers+=1;
              }
          }
      }

    Summary summary= Summary(totalQuestions: totalQuestion,correctAnswers: correctAnswers,incorrectAnswers: incorrectAnswers);
    return summary;

  }

  @override
  String toString() {
    return 'Summary{totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers}';
  }


}


//List<Question>  getDummyQuestions()
//{
//  List<Question> questions=new List();
//
//  questions.add(Question("1", "Grand Central Terminal, Park Avenue, New York is the world's",[
//    Options("Largest railway station","1",true),
//    Options("Highest railway station","2",false),
//    Options("Longest railway station","2",false),
//    Options("None of the above","3",false),
//  ]
//  ));
//
//  questions.add(Question( "Entomology is the science that studies",[
//    Options("Behavior of human beings","1",true),
//    Options("Insects","2",false),
//    Options("The origin and history of technical and scientific terms","2",false),
//    Options("The formation of rocks","3",false),
//  ]));
//
//  questions.add(Question( "Eritrea, which became the 182nd member of the UN in 1993, is in the continent of",[
//    Options("Asia","1",true),
//    Options("Africa","2",false),
//    Options("Europe","2",false),
//    Options("Australia","3",false),
//  ]));
//
//  questions.add(Question( "Garampani sanctuary is located at",[
//    Options("Junagarh, Gujarat","1",true),
//    Options("Diphu, Assam","2",false),
//    Options("Kohima, Nagaland","2",false),
//    Options("Gangtok, Sikkim","3",false),
//  ]));
//
//  questions.add(Question( "For which of the following disciplines is Nobel Prize awarded?",[
//    Options("Physics and Chemistry","1",true),
//    Options("Physiology or Medicine","2",false),
//    Options("All of the above","2",false),
//    Options("Literature, Peace and Economics","3",false),
//  ]));
//
//  questions.add(Question( "Hitler party which came into power in 1933 is known as",[
//    Options("Labour Party","1",true),
//    Options("Nazi Party","2",false),
//    Options("Ku-Klux-Klan","2",false),
//    Options("Democratic Party","3",false),
//  ]));
//
//  questions.add(Question( "How do you rate this app",[
//    Options("Good","1",true),
//    Options("Nice","2",false),
//    Options("Awesome","2",false),
//    Options("Bad","3",false),
//  ])..isOpinion=true);
//
//  return questions;
//}
//
//List<Question> getFeedbackQuestions()
//{
//  List<Question> questions=new List();
//
//  questions.add(Question( "This quiz app can help you in preparation of",[
//    Options("IOE/IOM Entrace","1",true),
//    Options("CMAT Exam","2",false),
//    Options("IELTS Exam","2",false),
//    Options("None of the above","3",false),
//  ]));
//
//  questions.add(Question( "Do you find the app useful?",[
//    Options("Yes","1",true),
//    Options("No","2",false),
//    Options("May be","2",false),
//    Options("I'm not sure","3",false),
//  ])..isOpinion=true);
//
//  questions.add(Question( "Have you used any app for entrance/exam preparation?",[
//    Options("I'm using currently","1",true),
//    Options("I tried but didn't like it","2",false),
//    Options("No","2",false),
//    Options("Yes","3",false),
//  ])..isOpinion=true);
//
//}