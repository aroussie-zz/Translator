import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myTranslator/models/Quiz.dart';
import 'package:myTranslator/utilities/Constants.dart';
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
  bool inEditMode = false;

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
                  child: (_quizzes == null &&
                          snapshot.connectionState != ConnectionState.done)
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
        child: GestureDetector(
            onLongPress: () => _showActionsLayout(context),
            child: Card(
                color: inEditMode ? Colors.black54 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(color: Colors.black, width: 1)),
                child: Stack(
                  children: <Widget>[
                    _buildQuizDisplay(context, quiz),
                    inEditMode ? _buildActionsDisplay(context, quiz) : Container()
                  ],
                ))));
  }

  Widget _buildQuizDisplay(BuildContext context, Quiz quiz) {
    return Column(
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
    );
  }

  Widget _buildActionsDisplay(BuildContext context, Quiz quiz) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    color: Colors.white,
                    child: IconButton(
                      iconSize: 34,
                      onPressed: () => _onEditQuizClicked(context),
                      color: Colors.black,
                      icon: Icon(Icons.edit),
                    ))),
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    color: Colors.white,
                    child: IconButton(
                      iconSize: 34,
                      onPressed: () => _onDeleteQuizClicked(quiz),
                      color: Colors.black,
                      icon: Icon(Icons.delete),
                    )))
          ],
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                color: Colors.white,
                child: IconButton(
                  iconSize: 34,
                  onPressed: () => _onCancelClicked(context),
                  color: Colors.red,
                  icon: Icon(Icons.cancel),
                )))
      ],
    );
  }

  void _showActionsLayout(BuildContext context) {
    setState(() {
      inEditMode = true;
    });
  }

  Future<int> _onDeleteQuizClicked(Quiz quiz) {
    var database = DatabaseHelper();
    return database.deleteQuiz(quiz);
  }

  void _onEditQuizClicked(BuildContext context) {}

  void _onCancelClicked(BuildContext context) {
    setState(() {
      inEditMode = false;
    });
  }

  void _onAddQuizClicked(BuildContext context) {
    Navigator.of(context).pushNamed(createQuizRoute);
  }

  void _startQuiz(Quiz quiz) {
    Navigator.pushNamed(context, quizRoute, arguments: quiz);
  }

  Future<List<Quiz>> _fetchQuizzed() {
    DatabaseHelper databaseHelper = DatabaseHelper();
    return databaseHelper.fetchQuizzes();
  }
}
