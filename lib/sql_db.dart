import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (defaultTargetPlatform != TargetPlatform.android)
    {
      // Initialize FFI
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
      if (_db == null){
        _db  = await intialDb() ;
        return _db ;  
      }else {
        return _db ; 
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
    //User table
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
    //Busses Table
    await db.execute('''
    CREATE TABLE "Bus" 
(
"Bus_no"             TEXT   PRIMARY KEY,
"Maintenance_id"     INTEGER,
"capacity"           INTEGER NOT NULL,
"driver_id"          INTEGER  
)
''');
    //Route Table
    await db.execute('''
CREATE TABLE Route 
(
"Route_id"                  TEXT   PRIMARY KEY,
"semester"                  TEXT Unique,
"year"                       INTEGER Unique,
"driver_id"                  INTEGER  ,
"passengers_id"              INTEGER  , 
"bus_no"                    TEXT,
"select_deadline"           TEXT,
"title"                     TEXT,

FOREIGN KEY (driver_id) REFERENCES User_Table (national_id)    
		ON UPDATE  CASCADE
		ON DELETE  SET NULL,
FOREIGN KEY (bus_no) REFERENCES Bus (Bus_no)     
		ON UPDATE  CASCADE
		ON DELETE  SET NULL
)
    ''');
    //Pick up point Table
    await db.execute('''
    CREATE TABLE Pick_up_Point 
(
"address"               TEXT UNIQUE,
"order_number"          INTEGER,
"route_id"              TEXT      ,
"time"                  TEXT NOT NULL,

PRIMARY KEY (order_number, route_id),
FOREIGN KEY (route_id) REFERENCES Route (Route_id)  
		ON UPDATE  CASCADE
		ON DELETE  CASCADE
)
    ''');
    //Trip Table
    await db.execute('''
    CREATE TABLE Trip 
(  
"Day"                  TEXT NOT NULL,
"Direction"            TEXT NOT NULL,
"Route_id"             TEXT NOT NULL,
"Bus_no"               TEXT, 
"time_at_university"   TEXT NOT NULL,

PRIMARY KEY (Route_id, Day , Direction, Bus_no),
FOREIGN KEY (Route_id) REFERENCES Route (Route_id) 
		ON UPDATE  CASCADE
		ON DELETE  NO ACTION,
FOREIGN KEY (Bus_no) REFERENCES Bus (Bus_no)
		ON UPDATE  NO ACTION       
		ON DELETE  NO ACTION
)
    ''');
    //Passenger Table
    await db.execute('''
    CREATE TABLE Passenger
(
"NationalID"                    INTEGER, 
"Email"                        TEXT NOT NULL,
"Payment_date"                 TEXT, 
"Route_id"                      TEXT ,
"Pick_up_Point_order_number"    INTEGER DEFAULT 0,
"Emergency_contact"              INTEGER NOT NULL,
"UST_id"                        INTEGER,
"Approval"                       TEXT,

PRIMARY KEY (NationalID),
FOREIGN KEY (Route_id) REFERENCES Route (Route_id)  
		ON UPDATE CASCADE
		ON DELETE NO ACTION,   
FOREIGN KEY (Pick_up_Point_order_number, Route_id) REFERENCES Pick_up_Point (order_number, route_id)
		ON UPDATE NO ACTION    
		ON DELETE NO ACTION
)
    ''');
    //Complaint Table
    await db.execute('''
    CREATE TABLE Complain 
(
"Passenger_id"         INTEGER NOT NULL,
"Day"                  TEXT NOT NULL,
"Direction"            TEXT NOT NULL,
"Route_id"             TEXT NOT NULL,
"Bus_no"               TEXT, 
"Complain_id"          INTEGER NOT NULL,
"Complaint_date"        TEXT NOT NULL, 
"Description"           TEXT NOT NULL,
"Title"                  TEXT,

PRIMARY KEY (Complain_id),
FOREIGN KEY (Passenger_id) REFERENCES Passenger (NationalID)            
		ON UPDATE  CASCADE
		ON DELETE  CASCADE,
FOREIGN KEY (Route_id, Day , Direction, Bus_no) REFERENCES Trip  (Route_id, Day , Direction, Bus_no)
		ON DELETE  CASCADE
)
    ''');
    //Exception Table
    await db.execute('''
    CREATE TABLE Exception 
(
"Exception_id"               INTEGER NOT NULL,
"Passenger_id"               INTEGER NOT NULL ,
"Current_Day"                  TEXT NOT NULL,
"Current_Direction"            TEXT NOT NULL,
"Current_Route_id"             TEXT NOT NULL,
"Current_Bus_no"               TEXT, 
"Demanded_Day"                  TEXT NOT NULL,
"Demanded_Direction"            TEXT NOT NULL,
"Demanded_Route_id"            TEXT NOT NULL,
"Demanded_Bus_no"               TEXT, 
"Approval"                     TEXT,

PRIMARY KEY (Exception_id, Passenger_id, Current_Day, Current_Direction, Current_Route_id, Current_Bus_no, Demanded_Day, Demanded_Direction, Demanded_Route_id, Demanded_Bus_no),

FOREIGN KEY (Passenger_id) REFERENCES Passenger (NationalID)
		ON UPDATE  CASCADE
		ON DELETE  CASCADE,
FOREIGN KEY (Current_Route_id, Current_Day, Current_Direction, Current_Bus_no) REFERENCES Trip  (Route_id, Day , Direction, Bus_no)
		ON UPDATE  NO ACTION   
		ON DELETE  NO ACTION,  
FOREIGN KEY (Demanded_Route_id, Demanded_Day,  Demanded_Direction, Demanded_Bus_no) REFERENCES Trip  (Route_id, Day , Direction, Bus_no)
		ON UPDATE  NO ACTION    
		ON DELETE  NO ACTION
)
    ''');
    //Maintenance Table
    await db.execute('''
    CREATE TABLE Maintenance 
(
"Maintenance_id"    INTEGER NOT NULL,
"Bus_no"            TEXT NOT NULL,
"Start_time"        TEXT,
"End_time"          TEXT,

PRIMARY KEY (Maintenance_id),
FOREIGN KEY (Bus_no ) REFERENCES Bus (Bus_no)
		ON UPDATE  CASCADE
		ON DELETE CASCADE
)
    ''');
    //Attendance Table
    await db.execute('''
    CREATE TABLE Attended_By 
(
"Day"                  TEXT NOT NULL,
"Direction"            TEXT NOT NULL,
"Route_id"             TEXT NOT NULL,
"Bus_no"               TEXT, 
"Passenger_ID"         INTEGER NOT NULL, 
"No_Of_Attendees"      INTEGER ,

PRIMARY KEY (Route_id, Day , Direction, Bus_no, Passenger_ID),
FOREIGN KEY (Route_id, Day , Direction, Bus_no) REFERENCES Trip (Route_id, Day , Direction, Bus_no)
		ON UPDATE  NO ACTION   
		ON DELETE NO ACTION,   
FOREIGN KEY (Passenger_ID ) REFERENCES Passenger (NationalID)
		ON UPDATE  NO ACTION   
		ON DELETE NO ACTION
)
    ''');
    //Arrival Table
    await db.execute('''
    CREATE TABLE Arrived_at 
(
"Day"                  TEXT NOT NULL,
"Direction"            TEXT NOT NULL,
"Route_id"             TEXT NOT NULL,
"Bus_no"               TEXT, 
"order_number"         INTEGER,

PRIMARY KEY (Route_id, Day , Direction, Bus_no, order_number),
FOREIGN KEY (Route_id, Day , Direction, Bus_no) REFERENCES Trip  (Route_id, Day , Direction, Bus_no)
		ON UPDATE  CASCADE
		ON DELETE CASCADE,
FOREIGN KEY (order_number,  Route_id) REFERENCES Pick_up_Point  (order_number, route_id)
		ON UPDATE  NO ACTION   
		ON DELETE NO ACTION   
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

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ZC_Transportation.db');
    await deleteDatabase(path);
    print(" Deleted DB =====================================");
  }

  //await db.close();
  //Future close() async {
  //  final db = await database;
  //  _database = null;
  //  return db.close();
  //}
}

//await db.insert('Product', <String, Object?>{'title': 'Product 1'});
//await db.insert('Product', <String, Object?>{'title': 'Product 1'});

//var result = await db.query('Product');
//print(result);
// prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
