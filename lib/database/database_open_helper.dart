import 'package:path/path.dart';
import 'package:sekolahku/database/student_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOpenHelper {

  Future<Database> getDatabase() async {
    return _initiateDatabase();
  }

  Future<Database> _initiateDatabase() async {
    final databasePath = await getDatabasesPath();
    return openDatabase(
      join(databasePath, "sekolah.db"),
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade
    );
  }

  OnDatabaseCreateFn get _onCreate => (db, version) {
    const query = """
    CREATE TABLE ${StudentTable.tableName} ( ${StudentTable.idField} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${StudentTable.firstName} TEXT,
    ${StudentTable.lastName} TEXT,
    ${StudentTable.mobilePhone} TEXT,
    ${StudentTable.gender} TEXT,
    ${StudentTable.grade} TEXT,
    ${StudentTable.address} TEXT,
    ${StudentTable.hobbies} TEXT,
    ${StudentTable.birthDate} TEXT
    ) """;
    db.execute(query);
  };

  OnDatabaseVersionChangeFn get _onUpgrade => (db, oldVersion, newVersion) {
    if(oldVersion < newVersion) {
      const sql = "ALTER TABLE ${StudentTable.tableName} ADD ${StudentTable.birthDate} TEXT";
      db.execute(sql);
    }
  };
}