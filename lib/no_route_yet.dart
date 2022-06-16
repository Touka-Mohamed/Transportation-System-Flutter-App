import 'package:flutter/material.dart';

import 'current_route.dart';

class NoRouteYet extends StatefulWidget {
  const NoRouteYet({Key? key}) : super(key: key);

  @override
  State<NoRouteYet> createState() => _NoRouteYet();
}

class _NoRouteYet extends State<NoRouteYet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(title: const Text("")), body:
    Column(children: <Widget>[
      Expanded(child: ListView(

        children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(110, 200, 90, 0),
              child: const Text(
                'Your admin has not assigned you a route yet, please contact them!',
                style: TextStyle(fontSize: 25),
              )),

          Padding(
              padding: const EdgeInsets.fromLTRB(80, 40, 80, 0),
              child: Container(

                width: 50.0,
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: ElevatedButton(
                  child: const Center( child: Text(
                      'Okay', style: TextStyle(fontSize: 20))),
                  onPressed: () {
                    Navigator.pop(context);
                  },),

              )),


        ],
      ))
    ],
    ));
  }
}
