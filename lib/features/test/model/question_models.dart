

import 'package:flutter/cupertino.dart';

class Question
{
  Question(this.question, this.answerOptions)
  {
    this.isQuestionOpinion=false;
  }

  String question;
  List<AnswerOption> answerOptions;

  bool isQuestionOpinion;

  @override
  String toString() {
    return 'Question{question: $question, answerOptions: $answerOptions, isQuestionOpinion: $isQuestionOpinion}';
  }


}

class AnswerOption
{

  AnswerOption(this.answer, this.id, this.isCorrect)
  {
    this.isSelectedByUser=false;
  }

  String answer;
  String id;
  bool isCorrect;
  bool isSelectedByUser;

  @override
  String toString() {
    return 'AnswerOption{answer: $answer, id: $id, isCorrect: $isCorrect, isSelectedByUser: $isSelectedByUser}';
  }
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
        for(AnswerOption ans in question.answerOptions)
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


List<Question>  getDummyQuestions()
{
  List<Question> questions=new List();
  
  questions.add(Question( "Grand Central Terminal, Park Avenue, New York is the world's",[
    AnswerOption("Largest railway station","1",true),
    AnswerOption("Highest railway station","2",false),
    AnswerOption("Longest railway station","2",false),
    AnswerOption("None of the above","3",false),
  ]));

  questions.add(Question( "Entomology is the science that studies",[
    AnswerOption("Behavior of human beings","1",true),
    AnswerOption("Insects","2",false),
    AnswerOption("The origin and history of technical and scientific terms","2",false),
    AnswerOption("The formation of rocks","3",false),
  ]));

  questions.add(Question( "Eritrea, which became the 182nd member of the UN in 1993, is in the continent of",[
    AnswerOption("Asia","1",true),
    AnswerOption("Africa","2",false),
    AnswerOption("Europe","2",false),
    AnswerOption("Australia","3",false),
  ]));

  questions.add(Question( "Garampani sanctuary is located at",[
    AnswerOption("Junagarh, Gujarat","1",true),
    AnswerOption("Diphu, Assam","2",false),
    AnswerOption("Kohima, Nagaland","2",false),
    AnswerOption("Gangtok, Sikkim","3",false),
  ]));

  questions.add(Question( "For which of the following disciplines is Nobel Prize awarded?",[
    AnswerOption("Physics and Chemistry","1",true),
    AnswerOption("Physiology or Medicine","2",false),
    AnswerOption("All of the above","2",false),
    AnswerOption("Literature, Peace and Economics","3",false),
  ]));

  questions.add(Question( "Hitler party which came into power in 1933 is known as",[
    AnswerOption("Labour Party","1",true),
    AnswerOption("Nazi Party","2",false),
    AnswerOption("Ku-Klux-Klan","2",false),
    AnswerOption("Democratic Party","3",false),
  ]));

  questions.add(Question( "How do you rate this app",[
    AnswerOption("Good","1",true),
    AnswerOption("Nice","2",false),
    AnswerOption("Awesome","2",false),
    AnswerOption("Bad","3",false),
  ])..isQuestionOpinion=true);

  return questions;
}

List<Question> getFeedbackQuestions()
{
  List<Question> questions=new List();

  questions.add(Question( "This quiz app can help you in preparation of",[
    AnswerOption("IOE/IOM Entrace","1",true),
    AnswerOption("CMAT Exam","2",false),
    AnswerOption("IELTS Exam","2",false),
    AnswerOption("None of the above","3",false),
  ]));

  questions.add(Question( "Do you find the app useful?",[
    AnswerOption("Yes","1",true),
    AnswerOption("No","2",false),
    AnswerOption("May be","2",false),
    AnswerOption("I'm not sure","3",false),
  ])..isQuestionOpinion=true);

  questions.add(Question( "Have you used any app for entrance/exam preparation?",[
    AnswerOption("I'm using currently","1",true),
    AnswerOption("I tried but didn't like it","2",false),
    AnswerOption("No","2",false),
    AnswerOption("Yes","3",false),
  ])..isQuestionOpinion=true);

}