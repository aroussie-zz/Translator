import 'package:flutter/material.dart';
import 'package:myTranslator/models/Quiz.dart';
import 'package:myTranslator/utilities/DatabaseHelper.dart';

class QuizProvider extends ChangeNotifier {

  List<QuizModel> quizzes = [];
  QuizModel currentQuiz;

  bool isQuizOver = false;
  bool hasAnswered = false;
  final Quiz quiz;

  int rightAnswersCount = 0;

  QuizProvider({this.quiz});

  int get totalQuestions => quiz.questions.length;

  Future<List<QuizModel>> fetchQuizzes() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Quiz> fetchedQuizzes = await databaseHelper.fetchQuizzes();
    for (Quiz quiz in fetchedQuizzes){
      this.quizzes.add(QuizModel(quiz: quiz));
    }
    notifyListeners();
    return this.quizzes;
  }

  void setQuizUserActionVisibility(QuizModel quizModel, displayUserAction){
    QuizModel quiz = this.quizzes.elementAt(this.quizzes.indexOf(quizModel));
    quiz.updateWith(shouldDisplayUserAction: displayUserAction);
    notifyListeners();
  }

//  void updateQuizList(List<Quiz> quizzes) {
//    quizzes.map((quiz) =>
//        this.quizzes.add(QuizModel(quiz: quiz))
//    );
//    notifyListeners();
//  }

  void updateQuizOver(bool isOver) {
    isQuizOver = isOver;
    notifyListeners();
  }

  void updateHasAnswered(bool didAnswer) {
    hasAnswered = didAnswer;
    notifyListeners();
  }

  void increaseRightAnswerCount() {
    rightAnswersCount++;
    notifyListeners();
  }

}

class QuizModel {

  Quiz quiz;
  bool displayUserAction;
  bool isQuizOver;
  bool hasAnswered;
  int rightAnswersCount;

  QuizModel(
      {@required this.quiz, this.displayUserAction = false, this.isQuizOver = false,
        this.hasAnswered = false, this.rightAnswersCount = 0});

  void updateWith({Quiz quiz, bool shouldDisplayUserAction, bool isQuizOver,
    bool userHasAnswered, int rightAnswersCount}) {
    this.quiz = quiz ?? this.quiz;
    this.displayUserAction = shouldDisplayUserAction ?? this.displayUserAction;
    this.isQuizOver = isQuizOver ?? this.isQuizOver;
    this.hasAnswered = userHasAnswered ?? this.hasAnswered;
    this.rightAnswersCount = rightAnswersCount ?? this.rightAnswersCount;
  }

  void increaseRightAnswersCount() {
    this.rightAnswersCount++;
  }

}