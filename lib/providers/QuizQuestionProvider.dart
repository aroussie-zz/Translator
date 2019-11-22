import 'package:flutter/material.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizQuestionProvider extends ChangeNotifier {
  QuizQuestionProvider();

  List<QuizAnswer> _answers = [
    QuizAnswer(),
    QuizAnswer(),
    QuizAnswer(),
    QuizAnswer(),
  ];

  bool _questionIsValid = false;

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

  List<QuizAnswer> get getQuizAnswers => _answers;

  bool get isQuestionValid => _questionIsValid;
}
