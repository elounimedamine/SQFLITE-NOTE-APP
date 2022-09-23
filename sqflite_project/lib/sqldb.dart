import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 8, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade =====================================");
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''');

    await batch.commit();

//     await db.execute('''
//   CREATE TABLE "notes" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
//     "title" TEXT NOT NULL,
//     "note" TEXT NOT NULL
//   )
//  ''');
    print(" onCreate =====================================");
  }

// SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

// INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

// UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

// DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

//Remove DataBase
  removeDataBase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.db');
    await deleteDatabase(path);
  }

// SELECT V2 SQFLITE PRET
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

// INSERT V2 SQFLITE PRET
  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

// UPDATE V2 SQFLITE PRET
  update(String table, Map<String, Object?> values, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: mywhere);
    return response;
  }

// DELETE V2 SQFLITE PRET
  delete(String table, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: mywhere);
    return response;
  }
}
