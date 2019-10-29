import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListState createState() {
    return _NotesListState();
  }
}

class _NotesListState extends State<NotesListPage> {

  var _itemToDisplay = [
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo"),
    Text("Helllllllllllo")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Notes")),
        body: SafeArea(
            child: GridView.count(
                crossAxisCount: 2,
              children: _itemToDisplay.map((Widget text) {
                return new GridTile(child: text);
              }).toList(),
            )
        ));
  }
}
