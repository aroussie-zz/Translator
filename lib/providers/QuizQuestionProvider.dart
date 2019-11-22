import 'package:flutter/material.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizQuestionProvider extends ChangeNotifier {

  QuizQuestionProvider();

  List<QuizAnswer> _answers = [
    QuizAnswer()
  ];

  void addAnswer(){
    _answers.add(QuizAnswer());
    notifyListeners();
  }

  void deleteAnswer(){
    if (_answers.length > 0){
      _answers.removeLast();
    }
    notifyListeners();
  }

  List<QuizAnswer> get getQuizAnswers => _answers;


}