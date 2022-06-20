import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';

class CurrentRoutesUserPage extends StatefulWidget {
  SqlDb sqlDb = SqlDb();
  CurrentRoutesUserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CurrentRoutesUserPageState();
}

class CurrentRoutesUserPageState extends State<CurrentRoutesUserPage> {

  List<RouteContainer> routeContainers = [];
  @override
  void initState()
  {
    super.initState();
    init();
  }

  void init() async
  {
    List<Map> responses = await widget.sqlDb.getAllRoutes();
    for(var route in responses)
    {
      RouteContainer tempContainer = RouteContainer(routeID: route['Route_id'].toString(),);
      setState(()=>{ routeContainers.add(tempContainer) });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Current Routes", textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          children: routeContainers,
        ),
      ),
    );
  }
}

class RouteContainer extends StatefulWidget
{
  RouteContainer({Key? key, required this.routeID}) : super(key: key);
  bool visible = false;
  final String routeID;
  Color colorBasedOnStatus = Colors.greenAccent;
  List<String> pickupPoints = [];
  List<PickUpPointContainer> pickupPointsContainers = [];
  String title = '';
  int capacity = 42;
  int numOfPassengers = 0;
  @override
  State<StatefulWidget> createState() => RouteContainerState();

}

class RouteContainerState extends State<RouteContainer>
{
  SqlDb sqlDb = SqlDb();
  @override
  void initState()
  {
    super.initState();
    init();
  }

  void init() async
  {
    List<Map> routeResponse = await sqlDb.getRouteData(widget.routeID);
    List<Map> pickUpPointsResponse = await sqlDb.getPickupPointsByRouteID(widget.routeID);
    List<Map> passengerResponse = await sqlDb.getPassengerData(Globals.Instance.nationalID.toString());
    int passengersNo = await sqlDb.getPassengersNumberByRoute(widget.routeID);
    setState(()=> widget.numOfPassengers = passengersNo );

    setState(()=> widget.title = routeResponse[0]['title'].toString());
    String busNo = routeResponse[0]['bus_no'].toString();
    List<Map> busResponse = await sqlDb.getBusByNo(busNo);
    if(busResponse.isNotEmpty && busResponse[0]['capacity'].toString() != null && busResponse[0]['capacity'].toString().isNotEmpty)
    {
      setState(()=> widget.capacity = busResponse[0]['capacity']);
    }
    for(var point in pickUpPointsResponse)
    {
      PickUpPointContainer container = PickUpPointContainer(title: point['address'],);
      setState( () => widget.pickupPointsContainers.add(container));
    }

    if(passengerResponse[0]['Route_id'].toString() != null && passengerResponse[0]['Route_id'].toString().isNotEmpty)
    {
      return;
    }

    if(passengerResponse[0]['Route_id'].toString() == widget.routeID)
    {
      setState(()=> widget.colorBasedOnStatus = Colors.blueAccent);
    }

    if(widget.numOfPassengers == widget.capacity)
    {
      setState(()=> widget.colorBasedOnStatus = Colors.redAccent);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.colorBasedOnStatus,
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                        (states) => widget.colorBasedOnStatus),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 20)),
                    Text("${widget.numOfPassengers}/${widget.capacity}", style: const TextStyle(fontSize: 20)),
                  ]),
              onPressed: () {
                setState(() {
                  widget.visible = !widget.visible;
                });
              },
            ),
          ),
          Visibility(
            visible: widget.visible,
            child: Column(
              children: widget.pickupPointsContainers,
            ),
          ),
        ]));
  }
}

class PickUpPointContainer extends StatelessWidget
{
  const PickUpPointContainer({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        Text(title),
      ],
    );
  }

}