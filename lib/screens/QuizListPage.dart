import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Quiz.dart';
import 'package:myTranslator/screens/QuizCreatePage.dart';
import 'package:myTranslator/utilities/DatabaseHelper.dart';

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
          child: Icon(Icons.add), onPressed: () =>
          _onAddQuizClicked(context)
//          _fetchQuizzed()
      ),
    );
  }

  void _onAddQuizClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => QuizCreatePageBuilder()));
  }

  void _fetchQuizzed() async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    var quizzes = await databaseHelper.fetchQuizzes();
    print("Quizzes fetched! $quizzes");
  }
}
