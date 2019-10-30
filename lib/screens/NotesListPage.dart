import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Verb.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListState createState() {
    return _NotesListState();
  }
}

class _NotesListState extends State<NotesListPage> {
  var _verbTitleTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  var _verbTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

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

  var verb = new Verb(
      original_title: "BE",
      original_firstPerson: "I am",
      original_secondPerson: "You are",
      original_thirdPerson: "He/She is",
      original_fourthPerson: "We are",
      original_fifthPerson: "You are",
      original_sixthPerson: "They are",
      translated_title: "ÊTRE",
      translated_firstPerson: "Je suis",
      translated_secondPerson: "Tu es",
      translated_thirdPerson: "Il/Elle/On est",
      translated_fourthPerson: "Nous sommes",
      translated_fifthPerson: "Vous êtes",
      translated_sixthPerson: "Ils/Elles sont");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var tableWidth = size.width;
    var tableHeight =
        (size.height - kBottomNavigationBarHeight - kToolbarHeight) / 2.2;

    return Scaffold(
        appBar: AppBar(title: Text("My Notes")),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 12.0,
            crossAxisCount: 1,
            childAspectRatio: tableWidth / tableHeight,
            children: _itemToDisplay.map((Widget text) {
              return new Table(
                border: TableBorder.all(color: Colors.black, width: 1.0),
                children: [
                  _buildTableRowTitle(
                      verb.original_title, verb.translated_title),
                  _buildTableRow(
                      verb.original_firstPerson, verb.translated_firstPerson),
                  _buildTableRow(
                      verb.original_secondPerson, verb.translated_secondPerson),
                  _buildTableRow(
                      verb.original_thirdPerson, verb.translated_thirdPerson),
                  _buildTableRow(
                      verb.original_fourthPerson, verb.translated_fourthPerson),
                  _buildTableRow(
                      verb.original_fifthPerson, verb.translated_fifthPerson),
                  _buildTableRow(
                      verb.original_sixthPerson, verb.translated_sixthPerson)
                ],
              );
            }).toList(),
          ),
        )));
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
