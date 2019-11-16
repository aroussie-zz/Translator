import 'package:flutter/material.dart';
import 'package:myTranslator/models/Translation.dart';
import 'package:myTranslator/utilities/DatabaseHelper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TranslationListPage extends StatefulWidget {
  @override
  _TranslationListState createState() {
    return _TranslationListState();
  }
}

class _TranslationListState extends State<TranslationListPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Translation> _translations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Translations"),
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: _fetchTranslations(),
                builder: (context, snapshot) {
                  _translations = snapshot.data;
                  return _translations == null
                      ? Center(child: CircularProgressIndicator())
                      : _translations.isNotEmpty
                          ? AnimatedList(
                              key: _listKey,
                              initialItemCount: _translations.length,
                              itemBuilder: (context, index, animation) {
                                return _buildListTile(
                                    _translations[index], animation);
                              })
                          : Center(
                              child: Text(
                                  "You don't have any saved translations."
                                  "Use the Translate tab to save some",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 2));
                })));
  }

  ///Build an item with animation that will be given by the AnimatedList
  Widget _buildListTile(Translation translation, Animation animation) {
    return SizeTransition(
        sizeFactor: animation,
        child: ListTile(
            title: Text(translation.originalSentence),
            subtitle: Text(translation.translatedSentence),
            trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteListItem(translation);
                })));
  }

  ///Delete an item with a nice animation
  void _deleteListItem(Translation itemToDelete) async {
    int indexToDelete = _translations.indexOf(itemToDelete);
    _translations.remove(itemToDelete);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildListTile(itemToDelete, animation);
    };

    _listKey.currentState.removeItem(indexToDelete, builder);

    var database = await openDatabase(
        join(await getDatabasesPath(), "my_translation_database.db"));
    database
        .delete("translation", where: "id = ?", whereArgs: [itemToDelete.id]);
  }

  ///Open or create a Database and fetch the exising translations
  Future<List<Translation>> _fetchTranslations() async {
    var databaseHelper = DatabaseHelper();
    return databaseHelper.fetchTranslations();
  }
}
