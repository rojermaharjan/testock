

class Question
{
  Question(this.question, this.answerOptions)
  {
    this.isQuestionOpinion=false;
  }

  String question;
  List<AnswerOption> answerOptions;

  bool isQuestionOpinion;

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