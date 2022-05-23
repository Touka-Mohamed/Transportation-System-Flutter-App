import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      // Initialize FFI
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ZC_Transportation.db');
    Database zc_db = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return zc_db;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE "User_Table"
(
"username"      TEXT,
"password"      TEXT,
"privilage"     INTEGER NOT NULL,
"national_id"   INTEGER   PRIMARY KEY ,
"name"          TEXT NOT NULL,
"age"           INTEGER,
"phone_number"  INTEGER NOT NULL
)
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? zc_db = await db;
    List<Map> response = await zc_db!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? zc_db = await db;
    int response = await zc_db!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? zc_db = await db;
    int response = await zc_db!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? zc_db = await db;
    int response = await zc_db!.rawDelete(sql);
    return response;
  }
}

//await db.insert('Product', <String, Object?>{'title': 'Product 1'});
//await db.insert('Product', <String, Object?>{'title': 'Product 1'});

//var result = await db.query('Product');
//print(result);
// prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
//await db.close();
