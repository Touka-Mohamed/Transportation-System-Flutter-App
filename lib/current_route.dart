import 'package:flutter/material.dart';
import 'package:gui/started_current_route.dart';

class CurrentRoute extends StatefulWidget {
  const CurrentRoute({Key? key}) : super(key: key);

  @override
  State<CurrentRoute> createState() => _CurrentRoute();
}

class _CurrentRoute extends State<CurrentRoute> {

  String descText1 = "Pickup point 1\nPickup point 2\nPickup point 3\nPickup point 4\nPickup point 5\nPickup point 6";
  String descText2 = "Passenger name 1\nPassenger name 2\nPassenger name 3\nPassenger name 4\nPassenger name 5\nPassenger name 6";

  bool descTextShowFlag = false;
  bool descTextShowFlag2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Route ID"),
        ),
        body: Column(children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              child: const Text(
                'Description',
                style: TextStyle(fontSize: 20),
              )),

          Container(

            width: 450.0,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: ElevatedButton(
              child: const Text('Pickup Points',style: TextStyle(fontSize: 20)),
              onPressed: () {
              },
            ),),

          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(descText1,
                    maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start),
                InkWell(
                  onTap: (){ setState(() {
                    descTextShowFlag = !descTextShowFlag;
                  }); },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      descTextShowFlag ? const Text("Show Less",style: TextStyle(color: Colors.blue),) :  const Text("Show More",style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 450.0,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: ElevatedButton(
              child: const Text('Passengers',style: TextStyle(fontSize: 20)),
              onPressed: () {
              },
            ),),


           Container(
            margin: const EdgeInsets.all(16.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(descText2,
                    maxLines: descTextShowFlag2 ? 8 : 2,textAlign: TextAlign.start),
                InkWell(
                  onTap: (){ setState(() {
                    descTextShowFlag2 = !descTextShowFlag2;
                  }); },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      descTextShowFlag2 ? const Text("Show Less",style: TextStyle(color: Colors.blue),) :  const Text("Show More",style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
              ],
            ),
          ),



          ElevatedButton(
            child: const Text('Start Route',style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {return const StartedCurrentRoute();}));
            },
          ),

        ]));
  }
}
