import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myTranslator/customWidget/PlatformDialog.dart';
import 'package:myTranslator/models/Quiz.dart';
import 'package:myTranslator/providers/QuizProvider.dart';
import 'package:myTranslator/utilities/Constants.dart';
import 'package:myTranslator/utilities/DatabaseHelper.dart';
import 'package:provider/provider.dart';

//class QuizListPage extends StatefulWidget {
//  @override
//  _QuizListState createState() {
//    return _QuizListState();
//  }
//}

class QuizListPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizProvider>(
      builder: (context) => QuizProvider(),
      child: Consumer<QuizProvider>(
          builder: (context, model, child) =>
              Scaffold(
                key: _key,
                appBar: AppBar(title: Text("My Quizzes")),
                body: SafeArea(
                    child: FutureBuilder(
                        future: model.fetchQuizzes(),
                        builder: (context, snapshot) {
//                          _quizzes = snapshot.data;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (snapshot.data == null &&
                                snapshot.connectionState !=
                                    ConnectionState.done)
                                ? Center(child: CircularProgressIndicator())
                            //TODO: Seperate the quizzes == null scenario and display an Snackbar error instead
                                : (model.quizzes != null &&
                                model.quizzes.isNotEmpty)
                                ? StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8,
                                itemCount: model.quizzes.length,
                                itemBuilder: (BuildContext context,
                                    int index) =>
                                    _buildQuizCard(context, model.quizzes[index]),
                                staggeredTileBuilder: (int index) {
                                  return StaggeredTile.count(1, 1);
                                })
                                : Center(child: Text("No saved Quizzes")),
                          );
                        })),
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _onAddQuizClicked(context)),
              )
      ),
    );
  }

//class _QuizListState extends State<QuizListPage> {
//  List<Quiz> _quizzes;
//  bool inEditMode = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _key,
//      appBar: AppBar(title: Text("My Quizzes")),
//      body: SafeArea(
//          child: FutureBuilder(
//              future: _fetchQuizzed(),
//              builder: (context, snapshot) {
//                _quizzes = snapshot.data;
//                return Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: (_quizzes == null &&
//                          snapshot.connectionState != ConnectionState.done)
//                      ? Center(child: CircularProgressIndicator())
//                      //TODO: Seperate the quizzes == null scenario and display an Snackbar error instead
//                      : (_quizzes != null && _quizzes.isNotEmpty)
//                          ? StaggeredGridView.countBuilder(
//                              crossAxisCount: 2,
//                              mainAxisSpacing: 8.0,
//                              crossAxisSpacing: 8,
//                              itemCount: _quizzes.length,
//                              itemBuilder: (BuildContext context, int index) =>
//                                  _buildQuizCard(context, _quizzes[index]),
//                              staggeredTileBuilder: (int index) {
//                                return StaggeredTile.count(1, 1);
//                              })
//                          : Center(child: Text("No saved Quizzes")),
//                );
//              })),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.add), onPressed: () => _onAddQuizClicked(context)),
//    );
//  }

  Widget _buildQuizCard(BuildContext context, QuizModel quizModel) {
    return new GestureDetector(
        onTap: () => _startQuiz(quizModel.quiz, context),
        child: GestureDetector(
            onLongPress: () => _showActionsLayout(context, quizModel),
            child: Card(
                color: quizModel.displayUserAction ? Colors.black54 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(color: Colors.black, width: 1)),
                child: Stack(
                  children: <Widget>[
                    _buildQuizDisplay(context, quizModel.quiz),
                    quizModel.displayUserAction ? _buildActionsDisplay(context, quizModel) : Container()
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

  Widget _buildActionsDisplay(BuildContext context, QuizModel quizModel) {
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
                      onPressed: () => _onDeleteQuizClicked(context, quizModel),
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
                  onPressed: () => _onCancelClicked(context, quizModel),
                  color: Colors.red,
                  icon: Icon(Icons.cancel),
                )))
      ],
    );
  }

  void _showActionsLayout(BuildContext context, QuizModel quizModel) {
    Provider.of<QuizProvider>(context).setQuizUserActionVisibility(quizModel, true);
//    setState(() {
//      inEditMode = true;
//    });
  }

  void _onDeleteQuizClicked(BuildContext context, QuizModel quizModel){
    PlatformDialog(
      titleWidget: Text("Delete quiz"),
      content: Text("Are you sure you want to delete ${quizModel.quiz.title}?"),
      defaultActionText: "Delete",
      defaultAction: () => _deleteQuiz(quizModel, context),
      negativeActionText: "Cancel",
      negativeAction: () => Navigator.of(context, rootNavigator: true).pop(),
    ).show(context);
  }

  void _deleteQuiz(QuizModel quizModel, BuildContext context) async {
    var database = DatabaseHelper();
    //TODO: PUT THAT IN PROVIDER
    int success = await database.deleteQuiz(quizModel.quiz);
    Navigator.of(context, rootNavigator: true).pop();

    if (success != 0) {
      final snackbar = SnackBar(
        content: Text("${quizModel.quiz.title} has been deleted successfully",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
          duration: Duration(seconds: 2)
      );
      _key.currentState.showSnackBar(snackbar);
      Provider.of<QuizProvider>(context).setQuizUserActionVisibility(quizModel, false);
    } else {
      final snackbar = SnackBar(
        content: Text("Something went wrong",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      );
      _key.currentState.showSnackBar(snackbar);
    }
  }

  void _onEditQuizClicked(BuildContext context) {}

  void _onCancelClicked(BuildContext context, QuizModel quizModel) {
    Provider.of<QuizProvider>(context).setQuizUserActionVisibility(quizModel, false);
//    setState(() {
//      inEditMode = false;
//    });
  }

  void _onAddQuizClicked(BuildContext context) {
    Navigator.of(context).pushNamed(createQuizRoute);
  }

  void _startQuiz(Quiz quiz, BuildContext context) {
    Navigator.pushNamed(context, quizRoute, arguments: quiz);
  }

  Future<List<Quiz>> _fetchQuizzed() {
    DatabaseHelper databaseHelper = DatabaseHelper();
    return databaseHelper.fetchQuizzes();
  }
}
