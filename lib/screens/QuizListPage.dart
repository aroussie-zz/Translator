import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Quiz.dart';
import 'package:myTranslator/screens/QuizCreatePage.dart';
import 'package:myTranslator/utilities/DatabaseHelper.dart';

class QuizListPage extends StatefulWidget {
  @override
  _QuizListState createState() {
    return _QuizListState();
  }
}

class _QuizListState extends State<QuizListPage> {
  final GlobalKey _key = GlobalKey();
  List<Quiz> _quizzes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Quizzes")),
      body: SafeArea(
          child: FutureBuilder(
              future: _fetchQuizzed(),
              builder: (context, snapshot) {
                _quizzes = snapshot.data;
                return _quizzes == null
                    ? Center(child: CircularProgressIndicator())
                    : _quizzes.isNotEmpty
                        ? Center(
                            child: Text("You have ${_quizzes.length} quizzes!"),
                          )
                        : Center(
                            child: Text("No saved Quizzes"),
                          );
              })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _onAddQuizClicked(context)),
    );
  }

  void _onAddQuizClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => QuizCreatePageBuilder()));
  }

  Future<List<Quiz>> _fetchQuizzed() {
    DatabaseHelper databaseHelper = DatabaseHelper();
    return databaseHelper.fetchQuizzes();
  }
}
