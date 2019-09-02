import 'package:flutter/material.dart';
import 'package:myTranslator/models/Translation.dart';

import 'TranslatePage.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }

}

class _HomeListState extends State<HomeListPage> {

  List<Translation> _translations = [
    Translation.dummy(),
    Translation.dummy(),
    Translation.dummy(),
    Translation.dummy(),
    Translation.dummy()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Translations"),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: _translations.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_translations[index].originalSentence),
                  subtitle: Text(_translations[index].translatedSentence),
                  trailing: Icon(Icons.delete, color: Colors.red),
                );
              }
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TranslatePage()));
          }),
    );
  }


}