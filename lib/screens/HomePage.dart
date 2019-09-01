import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      //TODO: Use the Translation package
      _outputController.text = _inputController.text;
    });
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


}
