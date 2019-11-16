import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Quiz.dart';

import 'QuizPage.dart';

class QuizListPage extends StatefulWidget {
  @override
  _QuizListState createState() {
    return _QuizListState();
  }
}

class _QuizListState extends State<QuizListPage> {

  var _quiz = Quiz.dummy();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Quizzes")),
      body: SafeArea(
          child: Center(
        child: Text("No saved Quizzes"),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _onAddQuizClicked(context)),
    );
  }

  void _onAddQuizClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => QuizPage(key: _key, quiz: _quiz,)));
  }
}
