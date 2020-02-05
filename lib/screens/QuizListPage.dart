import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (_quizzes == null && snapshot.connectionState != ConnectionState.done)
                      ? Center(child: CircularProgressIndicator())
                      //TODO: Seperate the quizzes == null scenario and display an Snackbar error instead
                      : (_quizzes != null && _quizzes.isNotEmpty)
                          ? StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8,
                              itemCount: _quizzes.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  _buildQuizCard(context, _quizzes[index]),
                              staggeredTileBuilder: (int index) {
                                return StaggeredTile.count(1, 1);
                              })
                          : Center(child: Text("No saved Quizzes")),
                );
              })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _onAddQuizClicked(context)),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz) {
    return new GestureDetector(
        onTap: () => _startQuiz(quiz),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: Colors.black, width: 1)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                    child: Text(
                  "${quiz.title}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                )),
                Center(
                    child: Text(
                  "${quiz.questions.length} questions",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ))
              ],
            )));
  }

  void _onAddQuizClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => QuizCreatePageBuilder()));
  }

  void _startQuiz(Quiz quiz) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => QuizPageBuilder(quiz: quiz)));
  }

  Future<List<Quiz>> _fetchQuizzed() {
    DatabaseHelper databaseHelper = DatabaseHelper();
    return databaseHelper.fetchQuizzes();
  }
}
