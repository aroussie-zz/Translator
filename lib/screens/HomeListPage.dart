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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  //IMPLEMENT SQLITE INSTEAD
  List<Translation> _translations = [
    Translation.dummy(1),
    Translation.dummy(2),
    Translation.dummy(3),
    Translation.dummy(4),
    Translation.dummy(5),
    Translation.dummy(6),
    Translation.dummy(7),
    Translation.dummy(8),
    Translation.dummy(9),
    Translation.dummy(10),
    Translation.dummy(11),
    Translation.dummy(12),
    Translation.dummy(13),
    Translation.dummy(14),
    Translation.dummy(15)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Translations"),
      ),
      body: SafeArea(
          child: AnimatedList(
              key: _listKey,
              initialItemCount: _translations.length,
              itemBuilder: (context, index, animation) {
                return _buildListTile(_translations[index], animation);
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
  void _deleteListItem(Translation itemToDelete) {
    int indexToDelete = _translations.indexOf(itemToDelete);
    _translations.remove(itemToDelete);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildListTile(itemToDelete, animation);
    };

    _listKey.currentState.removeItem(indexToDelete, builder);
  }
}
