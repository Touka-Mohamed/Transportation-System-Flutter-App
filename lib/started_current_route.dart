import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';

class StartedCurrentRoute extends StatefulWidget {
  const StartedCurrentRoute({Key? key, required this.routeid, required this.route_title, required this.semester, required this.year, required this.bus_num}) : super(key: key);
  final String routeid;
  final String route_title;
  final String semester;
  final String year;
  final String bus_num;

  @override
  State<StartedCurrentRoute> createState() => _StartedCurrentRoute();
}

class _StartedCurrentRoute extends State<StartedCurrentRoute> {

  SqlDb sqlDb = SqlDb(); //instance of the database class


  String descText1 = "";
  String descText2 = "";

  bool descTextShowFlag = false;
  bool descTextShowFlag2 = false;

@override
  initState()
  {
    super.initState();
    init();
  }

  init() async
  {
    List<Map> pickuppoints = await sqlDb.getPickupPointsByRouteID(widget.routeid);
    for(int index = 0; index < pickuppoints.length; index++)
    {
        String point_address = pickuppoints[index]['address'].toString();
        descText1 = "$descText1 $point_address\n";
    }


    List<Map> passengers_data = await sqlDb.getPassengersByRoute(widget.routeid);
    for(int index = 0; index < passengers_data.length; index++)
    {
        int passenger_id = passengers_data[index]['NationalID'];
        List<Map> passenger_name1 = await sqlDb.getUserName(passenger_id);
        String passenger_name = passenger_name1[0]['name'].toString();

        descText2 = "$descText2 $passenger_name\n";
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("Route ${widget.routeid} (${widget.route_title})"),
        ),
        body: Column(children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              child:  Text(
                'Route Details:\nTitle: ${widget.route_title}\nPeriod: ${widget.semester} ${widget.year}\nBus: ${widget.bus_num}',
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
            child: Column(
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
            child: const Text('Advance Pickup Point',style: TextStyle(fontSize: 20)),
            onPressed: () {
            },
          ),

        ]));
  }
}