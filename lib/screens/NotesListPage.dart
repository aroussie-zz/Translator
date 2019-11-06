import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myTranslator/models/Verb.dart';
import 'package:myTranslator/utilities/DatabaseHelper.dart';

import 'VerbPage.dart';

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
  var _tableIconsHeight = 40;
  List<Verb> _verbs = [];

  var _VerbPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var tableWidth = size.width;
    var tableHeight = (size.height -
            kBottomNavigationBarHeight -
            kToolbarHeight +
            _tableIconsHeight) /
        2.2;

    return Scaffold(
      appBar: AppBar(title: Text("My Notes")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: _fetchVerbs(),
            builder: (context, snapshot) {
              _verbs = snapshot.data;
              return _verbs == null
                  ? Center(child: CircularProgressIndicator())
                  : _verbs.isNotEmpty
                      ? GridView.count(
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 12.0,
                          crossAxisCount: 1,
                          childAspectRatio: tableWidth / tableHeight,
                          children: _verbs.map((Verb verb) {
                            return new Column(
                              children: <Widget>[
                                _buildIconsRow(context, verb),
                                Table(
                                  border: TableBorder.all(
                                      color: Colors.black, width: 1.0),
                                  children: [
                                    _buildTableRowTitle(verb.original_title,
                                        verb.translated_title),
                                    _buildTableRow(verb.original_firstPerson,
                                        verb.translated_firstPerson),
                                    _buildTableRow(verb.original_secondPerson,
                                        verb.translated_secondPerson),
                                    _buildTableRow(verb.original_thirdPerson,
                                        verb.translated_thirdPerson),
                                    _buildTableRow(verb.original_fourthPerson,
                                        verb.translated_fourthPerson),
                                    _buildTableRow(verb.original_fifthPerson,
                                        verb.translated_fifthPerson),
                                    _buildTableRow(verb.original_sixthPerson,
                                        verb.translated_sixthPerson)
                                  ],
                                )
                              ],
                            );
                          }).toList(),
                        )
                      : Center(
                          child: Text(
                              "You don't have any saved verbs."
                              "You can add some by clicking on the + at the bottom of the screen!",
                              textAlign: TextAlign.center,
                              textScaleFactor: 2));
            }),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddButtonClicked(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildIconsRow(BuildContext context, Verb verb) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(color: Colors.black, width: 1),
                start: BorderSide(color: Colors.black, width: 1),
                end: BorderSide(color: Colors.black, width: 1))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _onDeleteClicked(context, verb)),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _onEditIconClicked(context, verb))
          ],
        ),
      ),
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

  void _onAddButtonClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VerbPage(_VerbPageKey)));
  }

  void _onDeleteClicked(BuildContext context, Verb verb) {}

  void _onEditIconClicked(BuildContext context, Verb verb) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VerbPage(_VerbPageKey, verb)));
  }

  ///Fetch verbs from the database
  Future<List<Verb>> _fetchVerbs() {
    var databaseHelper = DatabaseHelper();
    return databaseHelper.fetchVerbs();
  }
}
