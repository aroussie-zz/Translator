import 'package:myTranslator/models/Verb.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//See https://medium.com/@abeythilakeudara3/to-do-list-in-flutter-with-sqlite-as-local-database-8b26ba2b060e
class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  final String translationTable = "translation";
  final String verbTable = "verb";


  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }

    return _database;
  }

  Future<Database> _initializeDatabase() async {
    String databasePath =
        join(await getDatabasesPath(), "my_translator_database.db");

    var appDatabase =
        await openDatabase(databasePath, version: 1, onCreate: _createDatabase);

    return appDatabase;
  }

  /// Create the different tables within the database
  void _createDatabase(Database database, int newVersion) async {

    //Create a table for the translations
    await database.execute("CREATE TABLE $translationTable("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "originalSentence TEXT,"
        "translatedSentence TEXT,"
        "type TEXT)");

    //Create a table for the verbs
    await database.execute("CREATE TABLE $verbTable("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "originalTitle TEXT,"
        "originalFirstPerson TEXT,"
        "originalSecondPerson TEXT,"
        "originalThirdPerson TEXT,"
        "originalFourthPerson TEXT,"
        "originalFifthPerson TEXT,"
        "originalSixthPerson TEXT,"
        "translatedTitle TEXT,"
        "translatedFirstPerson TEXT,"
        "translatedSecondPerson TEXT,"
        "translatedThirdPerson TEXT,"
        "translatedFourthPerson TEXT,"
        "translatedFifthPerson TEXT,"
        "translatedSixthPerson TEXT)");
  }

  Future<int> insertVerb(Verb verb) async{
    Database db = await this.database;
    var results = db.insert(verbTable, verb.toMap());
    return results;
  }

  Future<List<Verb>> fetchVerbs() async {
    Database db = await this.database;
    var results = await db.query(this.verbTable);
    return List.generate(results.length, (index) {
      return Verb.fromDatabase(json: results[index]);
    });
  }




}