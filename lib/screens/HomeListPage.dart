import 'package:flutter/material.dart';
import 'package:myTranslator/models/Translation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'TranslatePage.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeListPage> {
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
                    ? CircularProgressIndicator()
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
                                    " Start translating sentences by pressing + at the bottom of the screen!",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2)
                          );
              })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TranslatePage()));
          }),
    );
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
  void _deleteListItem(Translation itemToDelete) async{
    int indexToDelete = _translations.indexOf(itemToDelete);
    _translations.remove(itemToDelete);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildListTile(itemToDelete, animation);
    };

    _listKey.currentState.removeItem(indexToDelete, builder);

    var database = await openDatabase(
        join(await getDatabasesPath(), "my_translation_database.db"));
    database.delete("translation", where: "id = ?", whereArgs: [itemToDelete.id]);
  }

  ///Open or create a Database and fetch the exising translations
  Future<List<Translation>> _fetchTranslations() async {
    var database = await openDatabase(
        join(await getDatabasesPath(), "my_translation_database.db"),
        onCreate: (db, version) {
      //Create the Translation table when created
      return db.execute("CREATE TABLE translation("
          "id INTEGER PRIMARY KEY,"
          "originalSentence TEXT,"
          "translatedSentence TEXT,"
          "type TEXT)");
    }, version: 1);

    final List<Map<String, dynamic>> maps = await database.query("translation");

    //TODO: Refactor the logic to sort the translations
    return List.generate(maps.length, (index) {
      return Translation(
        id: maps[index]['id'],
        originalSentence: maps[index]['originalSentence'],
        translatedSentence: maps[index]['translatedSentence'],
        type: maps[index]['type'],
      );
    });
  }
}
