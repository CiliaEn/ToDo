import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Namn och version av SQLite-databasen.
  static const _databaseName = "ToDoDatabase.db";
  static const _databaseVersion = 2;  // Versionsnummer för schema-migration.

  // Namn på tabellen som används i databasen.
  static const table = 'todo_table';

  // Privat konstruktor för att skapa en singleton-instans av DatabaseHelper.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Databasinstans, används för att undvika att öppna flera anslutningar till samma databas.
  static Database? _database;

  // Getter för databasen. Öppnar databasen om den inte redan är öppnad.
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;
  }

  // Initierar och öppnar databasen, skapar den om den inte finns.
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,  // Anropas för schema-migration vid behov.
    );
  }

  // Skapar tabellen när databasen skapas för första gången.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,  // Unik identifierare för varje uppgift.
        task TEXT NOT NULL,                    // Texten för uppgiften.
        completed BOOLEAN NOT NULL,            // Boolean för att markera om uppgiften är slutförd.
        imagePath TEXT                         // Sökväg till en bild, om den finns.
      )
    ''');
  }

  // Uppgraderar databasschemat vid en versionförändring.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Lägger till en ny kolumn 'imagePath' om databasen uppgraderas från version 1 till 2.
      await db.execute('ALTER TABLE $table ADD COLUMN imagePath TEXT');
    }
    // Ytterligare villkor för framtida versioner kan läggas till här.
  }
}
