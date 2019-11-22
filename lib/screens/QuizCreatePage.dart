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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create a Quiz")),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  children: provider.getQuizAnswers.map((QuizAnswer answer) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuizAnswerTile());
              }).toList()

//                <Widget>[
//                  Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: QuizAnswerTile()),
//                  Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: QuizAnswerTile()),
//                  Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: QuizAnswerTile()),
//                  Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: QuizAnswerTile()),
//                  Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: QuizAnswerTile())
//                ],
                  )
            ],
          ),
        )));
  }
}

class QuizAnswerTile extends StatefulWidget {
  @override
  QuizAnswerTileState createState() {
    return QuizAnswerTileState();
  }
}

class QuizAnswerTileState extends State<QuizAnswerTile> {
  bool _isCorrectAnswer;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _isCorrectAnswer = false;
    _textController = TextEditingController();
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
        )),
        IconButton(
            icon: Icon(Icons.check),
            color: _isCorrectAnswer == true ? Colors.green : Colors.grey,
            onPressed: () {
              if (!_isCorrectAnswer) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "${_textController.text} set as correct Answer",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ));
              }
              setState(() {
                _isCorrectAnswer = !_isCorrectAnswer;
              });
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
