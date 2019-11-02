import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerbPage extends StatefulWidget {
  @override
  _VerbState createState() {
    return _VerbState();
  }
}

class _VerbState extends State<VerbPage> {
  var _verbTitleTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  var _verbTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  var _originalTitleController = TextEditingController();
  var _originalFirstPersonController = TextEditingController();
  var _originalSecondPersonController = TextEditingController();
  var _originalThirdPersonController = TextEditingController();
  var _originalFourthPersonController = TextEditingController();
  var _originalFifthPersonController = TextEditingController();
  var _originalSixthPersonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add a Verb")),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Table(
                  border: TableBorder.all(width: 1, color: Colors.black),
                  children: [
                    _buildTableRowTitle(),
                    _buildTableRow("1st person"),
                    _buildTableRow("2nd person"),
                    _buildTableRow("3rd person"),
                    _buildTableRow("4th person"),
                    _buildTableRow("5th person"),
                    _buildTableRow("6th person"),
                  ]),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.save),
                      label: Text("SAVE"),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () => _saveVerb(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    )),
              ),
            ]),
          )),
        ));
  }

  TableRow _buildTableRow(String hint) {
    return TableRow(children: [
      TableCell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _originalFirstPersonController,
              style: _verbTextStyle,
              maxLength: 20,
              maxLines: null,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: hint,
              ),
              onChanged: (text) {
                print((_originalFirstPersonController.text));
              },
            )),
      ),
      TableCell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              style: _verbTextStyle,
              maxLength: 20,
              maxLines: null,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: hint,
              ),
            )),
      ),
    ]);
  }

  TableRow _buildTableRowTitle() {
    return TableRow(children: [
      TableCell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              style: _verbTitleTextStyle,
              maxLength: 20,
              maxLines: null,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "infinitive",
              ),
            )),
      ),
      TableCell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              style: _verbTitleTextStyle,
              maxLength: 20,
              maxLines: null,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "infinitive",
              ),
            )),
      ),
    ]);
  }

  void _saveVerb() {
    print("Button Clicked!");
  }
}
