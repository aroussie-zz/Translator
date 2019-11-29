import 'package:flutter/material.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizQuestionProvider extends ChangeNotifier {
  QuizQuestionProvider();

  int _currentIndex = 0;
  List<QuizQuestion> _questions = [QuizQuestion.empty()];
  bool _questionIsValid = false;
  bool _questionIsSaved = false;
  QuizQuestion _currentQuestion = QuizQuestion.empty();

  List<QuizAnswer> get _answers => _currentQuestion.answers;

  List<QuizQuestion> get getQuizQuestions => _questions;

  int get currentQuestionIndex => _currentIndex;

  QuizQuestion get getQuizQuestion => _currentQuestion;

  bool get isQuestionValid => _questionIsValid;
  bool get isQuestionSaved => _questionIsSaved;

  int get totalQuestions => _questions.length;

  set _answers(List<QuizAnswer> newAnswers) {
    _answers = newAnswers;
  }

  set index(int newIndex) {
    _currentIndex = newIndex;
    _answers = _questions[newIndex].answers;
    notifyListeners();
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
    _questionIsValid = false;
    _questionIsSaved = true;
    notifyListeners();
  }

  void goPreviousQuestion() {
    _currentIndex -= 1;
    _currentQuestion = _questions[_currentIndex];
    notifyListeners();
  }

  void goNextQuestion() {
    if(_currentIndex == _questions.length - 1){
      _questions.add(QuizQuestion.empty());
    }
    _currentIndex += 1;
    _currentQuestion = _questions[_currentIndex];
    _questionIsSaved = false;
    notifyListeners();
  }

  void saveQuiz(){

  }
}
