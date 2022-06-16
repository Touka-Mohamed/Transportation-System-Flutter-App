import 'package:flutter/material.dart';
import 'package:gui/current_route.dart';
import 'package:gui/sql_db.dart';

import 'no_route_yet.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key, required this.name, required this.phone, required this.natioanlId}) : super(key: key);
  //const DriverHomePage({Key? key}) : super(key: key);
  final String name;
  final int phone;
  final int natioanlId;

  @override
  State<DriverHomePage> createState() => _DriverHomePage();
}

class _DriverHomePage extends State<DriverHomePage> {
  //String get name => name;
  SqlDb sqlDb = SqlDb(); //instance of the database class

  @override
  Widget build(BuildContext context) {

    return Scaffold (appBar: AppBar(title: const Text(" ")), body:
    Column(children: <Widget>[
      Expanded(child: ListView(

        children: <Widget>[

          Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
              child:Image.asset('assets/images/user.png', height: 130,
                width: 130,)),

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              child: Text(
               '${widget.name} ',
                style: TextStyle(fontSize: 18),
              )),


          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child:  Text(
                'Phone: ${widget.phone} ',
                style: TextStyle(fontSize: 15),
              )),


          Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: Container(

                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: ElevatedButton(
                  child: Center( child: const Text(
                      'Current route',style: TextStyle(fontSize: 20))),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),

                  ),
                  onPressed: () async {
                    List<Map> response = await sqlDb.readData("select * from Route WHERE driver_id= '${widget.natioanlId}' ");
                    print(response);
                    if (response.length == 0) {
                      print("no route found");
                      Navigator.push(context, MaterialPageRoute(builder: (context) {return const NoRouteYet();}));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {return const CurrentRoute();}));
                    }

                  },),

              )),


        ],
      ))
    ],
    ));
  }
}
