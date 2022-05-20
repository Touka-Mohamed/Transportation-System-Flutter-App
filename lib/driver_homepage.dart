import 'package:flutter/material.dart';

import 'no_route_yet.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePage();
}

class _DriverHomePage extends State<DriverHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(title: const Text("")), body:
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
              child: const Text(
                'Your Name',
                style: TextStyle(fontSize: 18),
              )),

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Your Email address',
                style: TextStyle(fontSize: 15),
              )),

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Your phone address',
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {return const NoRouteYet();}));
                  },),

              )),


        ],
      ))
    ],
    ));
  }
}