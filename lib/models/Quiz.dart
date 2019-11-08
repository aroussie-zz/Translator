class Quiz {

  String title;
  List<QuizQuestion> questions = [];

  Quiz({this.title, this.questions});
  Quiz.initiate({this.title});

  Quiz.dummy(){
    title = "Dummy Quiz";
    questions = [
      QuizQuestion(
        question: "Question 1",
        answers: [
          QuizAnswer(answer: "First answer", isRightAnswer: false),
          QuizAnswer(answer: "second answer", isRightAnswer: false),
          QuizAnswer(answer: "third answer", isRightAnswer: true),
          QuizAnswer(answer: "fourth answer", isRightAnswer: false)
        ]
      ),
      QuizQuestion(
          question: "Question 2",
          answers: [
            QuizAnswer(answer: "First answer", isRightAnswer: true),
            QuizAnswer(answer: "second answer", isRightAnswer: false),
            QuizAnswer(answer: "third answer", isRightAnswer: false),
            QuizAnswer(answer: "fourth answer", isRightAnswer: false)
          ]
      )
    ];
  }


}




class QuizQuestion {

  String question;
  List<QuizAnswer> answers = [];

  QuizQuestion({this.question, this.answers});


}

class QuizAnswer {

  String answer;
  bool isRightAnswer;

  QuizAnswer({this.answer, this.isRightAnswer});


}