class Quiz {

  String title;
  List<QuizQuestion> questions = [];

  Quiz({this.title, this.questions});
  Quiz.initiate({this.title});

  Quiz.dummy(){
    title = "Dummy Quiz";
    for (int i = 0; i < 5; i++){
      questions.add(QuizQuestion(
          question: "Question $i",
          answers: [
            QuizAnswer(answer: "First answer", isRightAnswer: false),
            QuizAnswer(answer: "second answer", isRightAnswer: false),
            QuizAnswer(answer: "third answer", isRightAnswer: true),
            QuizAnswer(answer: "fourth answer", isRightAnswer: false)
          ]
      ));
    }
  }
}




class QuizQuestion {

  String question;
  List<QuizAnswer> answers = [];

  QuizQuestion({this.question, this.answers});

  QuizQuestion.empty(){
    this.question = "";
    this.answers = [
      QuizAnswer(),
      QuizAnswer(),
      QuizAnswer(),
      QuizAnswer()
    ];
  }


}

class QuizAnswer {

  String answer;
  bool isRightAnswer;

  QuizAnswer({this.answer = "", this.isRightAnswer = false});


}