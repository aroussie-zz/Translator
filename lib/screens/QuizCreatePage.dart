import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Quiz.dart';
import 'package:myTranslator/providers/QuizQuestionProvider.dart';
import 'package:provider/provider.dart';

class QuizCreatePageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizQuestionProvider>(
        builder: (_) => QuizQuestionProvider(),
        child: Consumer<QuizQuestionProvider>(
          builder: (_, QuizQuestionProvider provider, __) =>
              QuizCreatePage(model: provider),
        ));
  }
}

class QuizCreatePage extends StatefulWidget {
  final QuizQuestionProvider model;

  QuizCreatePage({Key key, @required this.model}) : super(key: key);

  @override
  _QuizCreatePageState createState() {
    return _QuizCreatePageState();
  }
}

class _QuizCreatePageState extends State<QuizCreatePage> {

  QuizQuestionProvider get provider => widget.model;
  TextEditingController _questionController;


  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: provider.getQuizQuestion.question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create a Quiz")),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Question ${provider.currentQuestionIndex + 1}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _questionController,
                decoration: InputDecoration(
                    labelText: "Question", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "Answers:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: ButtonBar(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => provider.deleteAnswer()),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => provider.addAnswer())
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                children: provider.getQuizQuestion.answers.map((QuizAnswer answer) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuizAnswerTile(answer: answer));
                }).toList()),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("Save question"),
                    color: provider.isQuestionValid == true
                        ? Colors.green
                        : Colors.grey,
//                    onPressed: provider.isQuestionValid == true
//                        ? () => _saveQuestion()
//                        : null),
                onPressed: () => _saveQuestion(),
              ),
            ))
          ],
        ))));
  }

  void _saveQuestion() {
    print("SAVE QUESTIONS!");
    provider.saveQuestion(_questionController.text);
    provider.goNextQuestion();
  }

  @override
  void dispose() {
    super.dispose();
    _questionController.dispose();
  }


}

class QuizAnswerTile extends StatefulWidget {
  final QuizAnswer answer;

  QuizAnswerTile({Key key, @required this.answer}) : super(key: key);

  @override
  QuizAnswerTileState createState() {
    return QuizAnswerTileState();
  }
}

class QuizAnswerTileState extends State<QuizAnswerTile> {

  QuizAnswer get answer => widget.answer;
  TextEditingController _textController;


  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: answer.answer);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: TextField(
          controller: _textController,
          style: TextStyle(fontSize: 18),
          decoration:
              InputDecoration(hintText: "Answer", border: OutlineInputBorder()),
          onChanged: (String text) => Provider.of<QuizQuestionProvider>(context)
              .updateAnswerText(answer, text),
        )),
        IconButton(
            icon: Icon(Icons.check),
            color: answer.isRightAnswer == true ? Colors.green : Colors.grey,
            onPressed: () {
              answer.isRightAnswer = !answer.isRightAnswer;
              if (answer.isRightAnswer) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "${_textController.text} set as correct Answer",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ));
              }
              Provider.of<QuizQuestionProvider>(context).updateAnswer(answer);
            })
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
}
