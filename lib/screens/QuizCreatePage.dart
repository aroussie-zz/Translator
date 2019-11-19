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
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              hintText: "Answer 1", border: OutlineInputBorder()),
                        )),
                        Text("Right answer?"),
                        Checkbox(value: false, onChanged: null)
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Answer1"),
                    trailing: Checkbox(value: false, onChanged: null),
                  ),
                  ListTile(
                    title: Text("Answer2"),
                    trailing: Checkbox(value: false, onChanged: null),
                  ),
                  ListTile(
                    title: Text("Answer3"),
                    trailing: Checkbox(value: false, onChanged: null),
                  ),
                  ListTile(
                    title: Text("Answer4"),
                    trailing: Checkbox(value: false, onChanged: null),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
