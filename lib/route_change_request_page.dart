import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gui/sql_db.dart';
import 'current_routes_user_page.dart';

class RouteRequestChangePage extends StatefulWidget
{
  const RouteRequestChangePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RouteRequestChangePageState();

}

class RouteRequestChangePageState extends State<RouteRequestChangePage>
{
  SqlDb sqlDb = SqlDb();
  bool showDesiredRoutes = false;
  var items = [
    'Dawn Trip',
    'Dusk Trip'
  ];

  List<bool> routes = [];
  List<RouteContainer> routeContainers = [];

  String? selectedRoute;
  String? selectedDate;
  String selectedDirection = 'Dawn Trip';
  onSelected(int order, String routeID)
  {
    selectedRoute = routeID;
    for(var route in routes)
    {
      route = false;
    }
    routes[order] = true;
  }

  @override
  initState()
  {
    super.initState();
    init();
  }

  init() async
  {
    List<Map> routeResponses = await sqlDb.getAllRoutes();
    for(int index = 0; index < routeResponses.length; index++)
    {
      RouteContainer tempContainer = RouteContainer(
        routeID: routeResponses[index]['Route_id'].toString(),
        order: index,
        onSelected: onSelected,
      );

      routeContainers.add(tempContainer);
      routes.add(false);
    }
  }

  bool checkDependencies()
  {
    return selectedRoute != null && selectedDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route change request", textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                ),
                child: const Text("Desired route", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    showDesiredRoutes = !showDesiredRoutes;
                  });
                },
              ),
            ),
            Visibility(
              visible: showDesiredRoutes,
                child: Column(
                children: routeContainers,
                )
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                ),
                child: const Text("Desired Date", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    DatePicker.showDatePicker(context, onChanged: (date){
                      setState(()=> selectedDate = date.toString());
                    });
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Text(
                selectedDate.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                "Which trip?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                ),
              ),
            ),
            DropdownButton(
                alignment: AlignmentDirectional.center,
                isExpanded: true,
                value: selectedDirection,
                items: items.map((String item)
                {
                  return DropdownMenuItem(
                    alignment: AlignmentDirectional.center,
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState(()=> selectedDirection = newValue!);
                }),

            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: (){
                  if( !checkDependencies() ){ return; }
                  sqlDb.addException(selectedDate.toString(), selectedDirection.toString(), selectedRoute.toString());
                  Navigator.pop(context);
                },
                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)),
                child: const Text(
                  "Done!",
                  style: TextStyle(color: Colors.white),),
              ),
            ),
            const Spacer(),
        ]
        )
      )
    );
  }

}

class RouteContainer extends StatefulWidget
{
  bool arePickupPointsVisible = false;
  bool isSelected;
  static const Color selectedColor = Colors.yellow;
  final int order;
  final String routeID;
  late int numOfPassengers;
  late String title;
  late int capacity;
  Color colorBasedOnStatus = Colors.greenAccent;
  Function(int order, String routeID)? onSelected;
  List<PickUpPointContainer> pickupPointsContainers = [];

  RouteContainer({Key? key, required this.order, required this.routeID, this.onSelected, this.isSelected = false, }) : super(key: key);
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
    List<Map> pickUpPointsResponse = await sqlDb.getPickupPoints(widget.routeID);
    List<Map> passengerResponse = await sqlDb.getPassengerData(Globals.Instance.nationalID.toString());
    widget.numOfPassengers = await sqlDb.getPassengersNumberByRoute(widget.routeID);

    widget.title = routeResponse[0]['title'].toString();
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

    if(widget.isSelected)
    {
      setState(()=> widget.colorBasedOnStatus = RouteContainer.selectedColor);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlueAccent,
        child: Column(children:[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightBlueAccent),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 20)),
                    Text("${widget.numOfPassengers}/${widget.capacity}", style: const TextStyle(fontSize: 20)),
                  ]),
              onPressed: () {
                setState(() {
                  widget.arePickupPointsVisible = !widget.arePickupPointsVisible;
                });
              },
              onLongPress: (){ setState((){
                widget.isSelected = true;
                widget.onSelected!(widget.order, widget.routeID);
              }); },
            ),
          ),
          Visibility(
            visible: widget.arePickupPointsVisible,
            child: Column(
              children: widget.pickupPointsContainers,
            ),
          ),
        ]
        ));
  }

}