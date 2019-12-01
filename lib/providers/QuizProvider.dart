import 'package:flutter/material.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizProvider extends ChangeNotifier {

  bool isQuizOver = false;
  bool hasAnswered = false;
  final Quiz quiz;

  QuizProvider({this.quiz});

  void updateQuizOver(bool isOver){
    isQuizOver = isOver;
    notifyListeners();
  }

  void updateHasAnswered(bool didAnswer){
    hasAnswered = didAnswer;
    notifyListeners();
  }

}