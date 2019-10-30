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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a Verb")),
      body: SafeArea(
          child: Table(
              border: TableBorder.all(width: 1, color: Colors.black),
              children: [
            _buildTableRowTitle("hi", "hi"),
            _buildTableRowTitle("hi", "hi"),
            _buildTableRowTitle("hi", "hi"),
            _buildTableRowTitle("hi", "hi"),
            _buildTableRowTitle("hi", "hi"),
            _buildTableRowTitle("hi", "hi"),
            _buildTableRowTitle("hi", "hi"),
          ])),
    );
  }

  TableRow _buildTableRow(String firstCellString, String secondCellString) {
    return TableRow(children: [
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(firstCellString, style: _verbTextStyle),
      )),
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(secondCellString, style: _verbTextStyle),
      ))
    ]);
  }

  TableRow _buildTableRowTitle(String originalTitle, String translatedTitle) {
    return TableRow(children: [
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(originalTitle, style: _verbTitleTextStyle)),
      )),
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(translatedTitle, style: _verbTitleTextStyle)),
      ))
    ]);
  }
}
