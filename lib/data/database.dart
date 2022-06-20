import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

class database {
  static Database? _db;

  Future<Database?> get db async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      // Initialize FFI
      ffi.sqfliteFfiInit();
      ffi.createDatabaseFactoryFfi(ffiInit: initialDb);
      databaseFactory = ffi.databaseFactoryFfi;
    }
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ZC_Transportation.db');
    Database mydb = await openDatabase(path, //open connection
        onCreate: _onCreate,
        version: 1,
        onUpgrade: _onUpgrade);
    return mydb;
  }

  Future close() async {
    //terminate connection
    var dbClient = await db;
    dbClient!.close();
  }

//=========================== onCreate function is called only once "1st time only" =====================
  _onCreate(Database db, int version) async {
    print('Creating');
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
"semester"                  TEXT,
"year"                       INTEGER,
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

//========= after 1st time we can use onupgrade function instead of oncreate function =======================
//before using onupgrade function increment version
  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

//============================================== Crude functions ========================================
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    print("response:=======================================");
    print(response);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  ////////////////////////////////////////////////
  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ZC_Transportation.db');
    await deleteDatabase(path);
    print(" Deleted DB =====================================");
  }

  //Table-specific getters
  getUserData(String username, String password) async {
    List<Map> response = await readData(
        "select * from User_Table WHERE username= '${username}' and password= '${password}' ");
    return response;
  }

  // getAllPassengers() async {
  //   List<Map> responses = await readData("select * from Passenger ");
  //   return responses;
  // }

  getAllPassengers() async {
    List<Map> responses = await readData(
        '''select name,national_id,Email,address,phone_number,Emergency_contact,Route_id
         FROM User_Table,Passenger,Pick_up_Point 
         WHERE national_id=NationalID and Route_id=route_id and order_number=Pick_up_Point_order_number; ''');
    return responses;
  }

  getPassengersNumberByRoute(String Route_id) async {
    List<Map> response =
        await readData("select * from Passenger WHERE Route_id = '$Route_id' ");
    return response.length;
  }

  getPassengerData(String nationalID) async {
    List<Map> response = await readData(
        "select * from Passenger WHERE NationalID = '$nationalID' ");
    return response;
  }

  getRouteData(String routeID) async {
    List<Map> response =
        await readData("select * from Route WHERE Route_id= '$routeID'");
    return response;
  }

  getNumberOfRoutes() async {
    List<Map> routeResponse = await getAllRoutes();
    return routeResponse.length;
  }

  getAllRoutes() async {
    List<Map> response = await readData("select * from Route");
    return response;
  }

  getPickupPointsByRouteID(String routeID) async {
    List<Map> responses = await readData(
        "select * from Pick_up_Point WHERE route_id = '$routeID'");
    return responses;
  }

  getAllPickupPoints() async {
    List<Map> responses = await readData("select * from Pick_up_Point ");
    return responses;
  }

  getBusByNo(String bus_no) async {
    List<Map> responses =
        await readData("select * from Bus WHERE Bus_no = '$bus_no'");
    return responses;
  }

  getNumberOfComplaints() async {
    List<Map> responses = await readData("select * from Complain");
    return responses.length;
  }

  getNumberOfExceptions() async {
    List<Map> responses = await readData("select * from Exception");
    return responses.length;
  }

  getAllBusses() async {
    List<Map> responses = await readData("select * from Bus");
    return responses;
  }

  getAllComplaints() async {
    List<Map> responses = await readData("select * from Complain");
    return responses;
  }

  getAllTrips() async {
    List<Map> responses = await readData("select * from Trip");
    return responses;
  }

  getAllMaintenance() async {
    List<Map> responses = await readData("select * from Maintenance");
    return responses;
  }

  addComplaintInternal(
    int passengerID,
    String date,
    String direction,
    String routeID,
    String busNo,
    int complaintID,
    String complaintDate,
    String description,
    String title,
  ) async {
    String query = 'INSERT into Complain '
        'VALUES( "$passengerID", '
        '"$date", '
        '"$direction", '
        '"$routeID", '
        '"$busNo", '
        '"$complaintID", '
        '"$complaintDate", '
        '"$description", '
        '"$title")';
    await insertData(query);
  }

  addUser(String userName, String password, int privilege, int nationalID,
      String name, int age, int mobileNo) async {
    String query = 'INSERT INTO User_Table '
        'VALUES( "$userName", '
        '"$password", '
        '"$privilege", '
        '"$nationalID", '
        '"$name", '
        '"$age", '
        '"$mobileNo")';
    await insertData(query);
  }

  addPassenger(
    int nationalID,
    String email,
    int emergencyContact,
    int ustID,
    String approval, {
    String paymentDate = '',
    String routeID = '',
    int pickUpPointOrderNumber = 0,
  }) async {
    String query = 'INSERT into Passenger '
        'VALUES( "$nationalID", '
        '"$email", '
        '"$paymentDate", '
        '"$routeID", '
        '"$pickUpPointOrderNumber", '
        '"$emergencyContact", '
        '"$ustID", '
        '"$approval")';
    await insertData(query);
  }

  addComplaint(
      String date, String direction, String description, String title) async {
    String complaintDate = DateTime.now().toString();
    int complaintID = await getNumberOfComplaints();
    int passengerID = Globals.Instance.nationalID;
    List<Map> passengerResponse =
        await getPassengerData(Globals.Instance.nationalID.toString());
    String routeID = passengerResponse[0]['Route_id'].toString();
    String query = 'INSERT into Complain '
        'VALUES( "$passengerID", '
        '"$date", '
        '"$direction", '
        '"$routeID", '
        ', '
        '"$complaintID", '
        '"$complaintDate", '
        '"$description", '
        '"$title")';
    await insertData(query);
  }

  addException(
    String demandedDay,
    String demandedDirection,
    String demandedRouteID,
  ) async {
    int passengerID = Globals.Instance.nationalID;
    String currentDay = DateTime.now.toString();
    String currentDirection = demandedDirection;
    String currentRouteID;
    int exceptionID = getNumberOfExceptions();
    List<Map> passengerResponse =
        getPassengerData(Globals.Instance.nationalID.toString());
    currentRouteID = passengerResponse[0]['Route_id'].toString();

    String query = 'INSERT into Exception '
        'VALUES( "$passengerID", '
        '"$currentDay", '
        '"$currentDirection", '
        '"$currentRouteID", '
        ', '
        '"$demandedDay", '
        '"$demandedDirection", '
        '"$demandedRouteID", '
        '"", '
        '"")';
    await insertData(query);
  }

  addRoute(String semester, year, String selectDeadline, String title,
      {String driverID = '', String busNo = ''}) async {
    int routeID = await getNumberOfRoutes();

    String query = 'INSERT into Route '
        'VALUES( $routeID, '
        '"$semester", '
        '"$year", '
        '"$driverID", '
        '"", '
        '"$busNo", '
        '"$selectDeadline", '
        '"$title")';
    await insertData(query);
  }

  addPickUpPoint(
      String address, int orderNo, String routeID, String time) async {
    String query = 'INSERT into Pick_up_Point '
        'VALUES( "$address", '
        '"$orderNo", '
        '"$routeID", '
        '"$time")';
    await insertData(query);
  }

  addBus(
      String busNo, int capacity, String maintenanceID, String driverID) async {
    String query = 'INSERT into Bus '
        'VALUES( "$busNo", '
        '"$maintenanceID", '
        '"$capacity", '
        '"$driverID")';
    await insertData(query);
  }

  addTripInternal(String date, String direction, String routeID, String busNo,
      String arrivalTime) async {
    String query = 'INSERT into Trip '
        'VALUES( "$date", '
        '"$direction", '
        '"$routeID", '
        '"$busNo", '
        '"$arrivalTime")';
    await insertData(query);
  }

  addMaintenance(int Maintenance_id, String Bus_no, String Start_time,
      String End_time) async {
    String query = 'INSERT into Maintenance '
        'VALUES( "$Maintenance_id", '
        '"$Bus_no", '
        '"$Start_time", '
        '"$End_time")';
    await insertData(query);
  }

  deleteMaintanance(int Maintenance_id) async {
    String query =
        'DELETE FROM Maintenance WHERE Maintenance_id =?,["$Maintenance_id"]';
  }
}

//await db.insert('Product', <String, Object?>{'title': 'Product 1'});
//await db.insert('Product', <String, Object?>{'title': 'Product 1'});

//var result = await db.query('Product');
//print(result);
// prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]

class Globals {
  static final Globals Instance = Globals._internal();
  factory Globals() {
    return Instance;
  }

  Globals._internal();

  int _nationalID = 0;

  int get nationalID => _nationalID;
  void setNationalID(int value) {
    _nationalID = value;
  }
}
