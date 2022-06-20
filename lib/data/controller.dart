import 'package:flutter/material.dart';
import 'package:gui/data/database.dart';

// ignore: camel_case_types
class controller {
  database dbMan = database();
  InsertBus(String Route, String Bus_no, int Capacity, String Driver_Name,
      int Driver_Contact) async {
    String query = '''INSERT INTO BusTest 
                            Values ("$Route","$Bus_no", "$Capacity" ," $Driver_Name  ", "$Driver_Contact");''';
    await dbMan.insertData(query);
  }

  selectall_buses() {
    String query = 'SELECT * FROM BusTest';
    return dbMan.readData(query);
  }
}
