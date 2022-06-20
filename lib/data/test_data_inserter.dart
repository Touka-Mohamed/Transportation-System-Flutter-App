import 'package:flutter/cupertino.dart';
import 'package:gui/sql_db.dart';

class DataInserter
{
  static List<List<Data>> allData = [
    UserData.allUserData,
    PassengerData.allPassengerData,
    RouteData.allRouteData,
    PickUpPointData.allPickUpPoints,
  ];
  static void insertAll() async
  {
    for(var dataList in allData)
    {
      for (var dataPiece in dataList)
      {
        try {
          await dataPiece.insert();
        }
        catch(identifier)
        {
          print(identifier);
        }
      }
    }
  }
}

abstract class Data<T>
{
  Future<void> insert();
}

class RouteData extends Data
{
  static List<RouteData> allRouteData = [
    RouteData()
    ..title = 'Haram'
    ..busNo = '0'
    ..driverID = '0'
    ..year = 2022
    ..selectDeadline = 2023
    ..semester = 'Fall',

    RouteData()
      ..title = 'Sheraton'
      ..busNo = '1'
      ..driverID = '1'
      ..year = 2023
      ..selectDeadline = 2023
      ..semester = 'Fall2',
  ];

  late String semester;
  late int year;
  late int selectDeadline;
  late String title;
  String driverID = '';
  String busNo = '';

  @override
  Future<void> insert() async => await SqlDb().addRoute(semester, year, selectDeadline.toString(), title, driverID: driverID, busNo: busNo);
}

class UserData extends Data
{
  static List<UserData> allUserData = [
    UserData()
    ..nationalID = 0
    ..mobileNo = 011
    ..name = 'HaramDriver'
    ..age = 43
    ..userName = 'driver1'
    ..password = '12340'
    ..privilege = 3,

    UserData()
      ..nationalID = 1
      ..mobileNo = 012
      ..name = 'SheratonDriver'
      ..age = 42
      ..userName = 'driver2'
      ..password = '12340'
      ..privilege = 3,

  ];

  late String userName;
  late String password;
  late int privilege;
  late int nationalID;
  late String name;
  late int age;
  late int mobileNo;

  @override
  Future<void> insert() async => await SqlDb().addUser(userName, password, privilege, nationalID, name, age, mobileNo);

}

class PassengerData extends Data
{
  static List<PassengerData> allPassengerData = [

  ];
  late int nationalID;
  late String email;
  late int emergencyContact;
  late int ustID;
  late String approval;
  String paymentDate = '';
  String routeID = '';
  int pickUpPointOrderNumber = 0;
  @override
  Future<void> insert() => SqlDb().addPassenger(
      nationalID,
      email,
      emergencyContact,
      ustID,
      approval,
      paymentDate: paymentDate,
      routeID: routeID,
      pickUpPointOrderNumber: pickUpPointOrderNumber
  );
}

class PickUpPointData extends Data
{
  static List<PickUpPointData> allPickUpPoints = [
    PickUpPointData()
    ..address = 'Manial'
    ..routeID = '0'
    ..orderNo = 0
    ..time = '6:40:00',

    PickUpPointData()
      ..address = 'Giza'
      ..routeID = '0'
      ..orderNo = 1
      ..time = '6:45:00',

    PickUpPointData()
      ..address = 'Nasr_Eldein'
      ..routeID = '0'
      ..orderNo = 2
      ..time = '6:50:00',

    PickUpPointData()
      ..address = 'Wimpy'
      ..routeID = '0'
      ..orderNo = 3
      ..time = '6:52:00',

    PickUpPointData()
      ..address = 'El-Salam_Mosque'
      ..routeID = '0'
      ..orderNo = 4
      ..time = '6:55:00',

    PickUpPointData()
      ..address = 'El-Tawheed_&_El-Noor'
      ..routeID = '0'
      ..orderNo = 5
      ..time = '6:57:00',

    PickUpPointData()
      ..address = 'El-Talbia'
      ..routeID = '0'
      ..orderNo = 6
      ..time = '7:00:00',

    PickUpPointData()
      ..address = 'Matba3a'
      ..routeID = '0'
      ..orderNo = 7
      ..time = '7:02:00',

    PickUpPointData()
      ..address = 'El-Areesh'
      ..routeID = '0'
      ..orderNo = 8
      ..time = '7:05:00',

    PickUpPointData()
      ..address = 'Haram_Hospital'
      ..routeID = '0'
      ..orderNo = 9
      ..time = '7:10:00',

    PickUpPointData()
      ..address = 'Masaken-Sheraton'
      ..routeID = '2'
      ..orderNo = 0
      ..time = '6:35:00',

    PickUpPointData()
      ..address = 'Omarat-El-Oboor'
      ..routeID = '2'
      ..orderNo = 1
      ..time = '6:45:00',

    PickUpPointData()
      ..address = 'Medan-El-Abasya'
      ..routeID = '2'
      ..orderNo = 2
      ..time = '6:50:00',

    PickUpPointData()
      ..address = '-Ghomra-'
      ..routeID = '2'
      ..orderNo = 3
      ..time = '6:55:00',
  ];
  late String address;
  late int orderNo;
  late String routeID;
  late String time;

  @override
  Future<void> insert() => SqlDb().addPickUpPoint(address, orderNo, routeID, time);

}