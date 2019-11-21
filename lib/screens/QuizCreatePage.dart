import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuizCreatePage extends StatefulWidget {
  @override
  _QuizCreatePageState createState() {
    return _QuizCreatePageState();
  }
}

class _QuizCreatePageState extends State<QuizCreatePage> {
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
                          IconButton(icon: Icon(Icons.remove), onPressed: null),
                          IconButton(icon: Icon(Icons.add), onPressed: null)
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuizAnswerTile()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuizAnswerTile()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuizAnswerTile()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuizAnswerTile()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuizAnswerTile())
                ],
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
