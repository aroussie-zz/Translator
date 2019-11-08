import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;

  QuizPage({Key key, @required this.quiz}) : super(key: key);

  @override
  _QuizPageState createState() {
    return _QuizPageState();
  }
}

class _QuizPageState extends State<QuizPage> {
  Quiz _quiz;

  bool _hasAnswered;
  int _positionButtonClicked;

  @override
  void initState() {
    _quiz = widget.quiz;
    _hasAnswered = false;
    _positionButtonClicked = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz: ${_quiz.title}")),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(_quiz.questions[0].question),
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGridView.countBuilder(
                itemCount: _quiz.questions[0].answers.length,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: _hasAnswered == true
                      //it's the question is answered, then only keep the right answer
                      //And where the user clicked
                          ? _quiz.questions[0].answers[index].isRightAnswer ==
                                  true
                              ? 1
                              : index == _positionButtonClicked ? 1 : 0
                          : 1,
                      child: RaisedButton(
                        child: Text(_quiz.questions[0].answers[index].answer),
                        onPressed: () => _onAnswerClicked(index),
                        color: _hasAnswered
                            ? _quiz.questions[0].answers[index].isRightAnswer ==
                                    true
                                ? Colors.green
                                : index == _positionButtonClicked
                                    ? Colors.red
                                    : Colors.white30
                            : Colors.white30,
                      ));
                },
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.count(1, 0.5);
                },
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Center(
              child: RaisedButton(
                  child: Text("Next"), onPressed: () => _onNextClicked()),
            ),
            flex: 1,
          )
        ],
      )),
    );
  }

  void _onAnswerClicked(int position) {
    setState(() {
      _hasAnswered = true;
      _positionButtonClicked = position;
    });
  }

  void _onNextClicked() {
    print("Next clicked!");
    setState(() {
      //TODO: GO to next question
      _hasAnswered = false;
    });
  }
}
