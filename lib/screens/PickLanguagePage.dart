import 'package:flutter/material.dart';
import 'package:myTranslator/models/Language.dart';

class PickLanguagePage extends StatefulWidget {
  final List<Language> languages;

  PickLanguagePage({Key key, this.languages}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PickLanguageState();
  }
}

class _PickLanguageState extends State<PickLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Original Language"),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: widget.languages == null ? 0 : widget.languages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text(widget.languages[index].name));
              },
              padding: EdgeInsets.all(8))),
    );
  }
}
