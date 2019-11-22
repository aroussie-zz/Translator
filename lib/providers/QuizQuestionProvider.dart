import 'package:flutter/material.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizQuestionProvider extends ChangeNotifier {
  QuizQuestionProvider();

  int _currentIndex = 0;
  List<QuizQuestion> _questions = [QuizQuestion.empty()];
  bool _questionIsValid = false;

  List<QuizAnswer> get _answers => _questions[_currentIndex].answers;

  List<QuizQuestion> get getQuizQuestions => _questions;

  int get currentQuestionIndex => _currentIndex;

  List<QuizAnswer> get getQuizAnswers => _answers;

  bool get isQuestionValid => _questionIsValid;

  int get totalQuestions => _questions.length;

  void addAnswer() {
    _answers.add(QuizAnswer());
    _questionIsValid = false;
    notifyListeners();
  }

  void deleteAnswer() {
    if (_answers.length > 0) {
      _answers.removeLast();
    }
    _determineIfQuestionIsValid();
  }

  void updateAnswerText(QuizAnswer answer, String text) {
    QuizAnswer listAnswer = _answers.elementAt(_answers.indexOf(answer));
    listAnswer.answer = text;
    _determineIfQuestionIsValid();
  }

  void updateAnswer(QuizAnswer answer) {
    QuizAnswer listAnswer = _answers.elementAt(_answers.indexOf(answer));
    listAnswer = answer;
    if (answer.isRightAnswer) {
      for (var savedAnswer in _answers) {
        if (savedAnswer != listAnswer) {
          savedAnswer.isRightAnswer = false;
        }
      }
    }
    //At any update we check if the data is valid
    _determineIfQuestionIsValid();
  }

  void _determineIfQuestionIsValid() {
    bool correctAnswerSet = false;

    for (var answer in _answers) {
      if (answer.answer.isEmpty) {
        _questionIsValid = false;
        notifyListeners();
        break;
      }
      if (answer.isRightAnswer && !correctAnswerSet) {
        correctAnswerSet = true;
      }
    }
    _questionIsValid = correctAnswerSet;
    notifyListeners();
  }

  void saveQuestion(String questionTitle) {
    QuizQuestion question = _questions[_currentIndex];
    question = QuizQuestion(question: questionTitle, answers: _answers);
    notifyListeners();
  }

  void goPreviousQuestion() {
    _currentIndex--;
    notifyListeners();
  }

  void goNextQuestion() {
    _questions.add(QuizQuestion.empty());
    _currentIndex++;
    notifyListeners();
  }
}
