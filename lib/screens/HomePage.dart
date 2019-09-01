import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Language.dart';
import 'package:translator/translator.dart';

import 'PickLanguagePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final translator = new GoogleTranslator();
  List<Language> _languages = [];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() async {
      String input = _inputController.text;
      _outputController.text = input.isEmpty
          ? ""
          : await translator.translate(_inputController.text,
              from: 'fr', to: 'en');
    });
    _fetchLocalLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("My Translator"),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTopBar(),
                _buildTranslationCard(),
                _buildButtons()
              ],
            )));
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: FlatButton(
          child: Text("French"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PickLanguagePage(
                          languages: _languages,
                        )));
          },
        )),
        IconButton(
          icon: Icon(Icons.compare_arrows),
        ),
        Expanded(
            child: FlatButton(
          child: Text("English"),
        )),
      ],
    );
  }

  Widget _buildTranslationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: "Text to translate",
                hintText: "Text to translate",
                border: OutlineInputBorder()),
            controller: _inputController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            maxLines: null,
          ),
        ),
      ],
    );
  }

  Widget _buildTranslationOutput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Translation",
                labelText: "Translation",
                border: OutlineInputBorder()),
            controller: _outputController,
            maxLines: null,
            enabled: true,
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTranslationCard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          _buildTranslationInput(),
          Divider(),
          _buildTranslationOutput(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.clear),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Clear"),
              )
            ],
          ),
          onPressed: () {
            _inputController.text = "";
          },
        ),
        RaisedButton(
            color: Colors.green,
            onPressed: () {
              print("SAVE!");
            },
            child: Row(children: <Widget>[
              Icon(Icons.save),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Save"),
              )
            ]))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
    _outputController.dispose();
  }

  void _fetchLocalLanguages() async {
    String localJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/languages.json');

    if (localJsonString == null) {
      return;
    }

    final parsedJson = json.decode(localJsonString.toString());
    if (parsedJson != null) {
      for (final key in parsedJson.keys) {
        _languages.add(Language(isoCode: key, name: parsedJson[key]));
      }
    }
    _languages
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
}
