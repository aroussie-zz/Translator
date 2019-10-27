import 'package:flutter/material.dart';
import 'package:myTranslator/models/Translation.dart';
import 'package:myTranslator/screens/TranslationListPage.dart';
import 'package:myTranslator/utilities/TabDestination.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'TranslatePage.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeListPage>
    with TickerProviderStateMixin<HomeListPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<Translation> _translations = [];
  int _currentIndex;
  int _indexToPopOut = 0;

  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "page0": GlobalKey<NavigatorState>(),
    "page1": GlobalKey<NavigatorState>(),
    "page2": GlobalKey<NavigatorState>(),
    "page3": GlobalKey<NavigatorState>(),
  };

  List<TabDestination> allTabDestinations = <TabDestination>[
    TabDestination(
        position: 0,
        title: 'Home',
        icon: Icons.home,
        color: Colors.blue,
        screen: TranslationListPage()),
    TabDestination(
        position: 1,
        title: 'Translate',
        icon: Icons.translate,
        color: Colors.blue,
        screen: TranslatePage()),
    TabDestination(
        position: 2,
        title: 'Notes',
        icon: Icons.receipt,
        color: Colors.blue,
        screen: TranslationListPage()),
    TabDestination(
        position: 3,
        title: 'Quizz',
        icon: Icons.school,
        color: Colors.blue,
        screen: TranslatePage())
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  Future<bool> _onWillPop() async {
    var canScreenPop =
        !await navigatorKeys["page$_currentIndex"].currentState.maybePop();
    if (!canScreenPop) {
      return canScreenPop;
    } else {
      setState(() {
        _currentIndex = _indexToPopOut;
      });
      return _currentIndex != _indexToPopOut;
    }
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            top: false,
            child: WillPopScope(
                onWillPop: () => _onWillPop(),
                child: IndexedStack(
                    index: _currentIndex,
                    children: allTabDestinations
                        .map<Widget>((TabDestination destination) {
                      return Navigator(
                          key: navigatorKeys["page${destination.position}"],
                          initialRoute: '/',
                          onGenerateRoute: (RouteSettings settings) =>
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      destination.screen));
                    }).toList()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: allTabDestinations.map((TabDestination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              title: Text(destination.title),
              backgroundColor: destination.color);
        }).toList(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _indexToPopOut = _currentIndex;
            _currentIndex = index;
          });
        },
      ),
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
