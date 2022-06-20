import 'package:flutter/material.dart';
import 'package:gui/started_current_route.dart';

class CurrentRoute extends StatefulWidget {
  const CurrentRoute({Key? key}) : super(key: key);

  @override
  State<CurrentRoute> createState() => _CurrentRoute();
}

class _CurrentRoute extends State<CurrentRoute> {
  SqlDb sqlDb = SqlDb(); //instance of the database class

  String descText1 = "";
  String descText2 = "";

  bool descTextShowFlag = false;
  bool descTextShowFlag2 = false;

  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    List<Map> pickuppoints =
        await sqlDb.getPickupPointsByRouteID(widget.routeid);
    for (int index = 0; index < pickuppoints.length; index++) {
      String point_address = pickuppoints[index]['address'].toString();
      descText1 = "$descText1 $point_address\n";
    }

    List<Map> passengers_data =
        await sqlDb.getPassengersByRoute(widget.routeid);
    for (int index = 0; index < passengers_data.length; index++) {
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
          title: const Text("Route ID"),
        ),
        body: Column(children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              child: Text(
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
              child:
                  const Text('Pickup Points', style: TextStyle(fontSize: 20)),
              onPressed: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(descText1,
                    maxLines: descTextShowFlag ? 8 : 2,
                    textAlign: TextAlign.start),
                InkWell(
                  onTap: () {
                    setState(() {
                      descTextShowFlag = !descTextShowFlag;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      descTextShowFlag
                          ? const Text(
                              "Show Less",
                              style: TextStyle(color: Colors.blue),
                            )
                          : const Text("Show More",
                              style: TextStyle(color: Colors.blue))
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
              child: const Text('Passengers', style: TextStyle(fontSize: 20)),
              onPressed: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(descText2,
                    maxLines: descTextShowFlag2 ? 8 : 2,
                    textAlign: TextAlign.start),
                InkWell(
                  onTap: () {
                    setState(() {
                      descTextShowFlag2 = !descTextShowFlag2;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      descTextShowFlag2
                          ? const Text(
                              "Show Less",
                              style: TextStyle(color: Colors.blue),
                            )
                          : const Text("Show More",
                              style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: const Text('Start Route', style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const StartedCurrentRoute();
              }));
            },
          ),
        ]));
  }
}
