import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RouteRequestChangePage extends StatefulWidget
{
  const RouteRequestChangePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RouteRequestChangePageState();

}

class RouteRequestChangePageState extends State<RouteRequestChangePage>
{
  bool showDesiredRoutes = false;

  bool route1 = false;
  bool route2 = false;
  bool route3 = false;
  Checkbox? selectedPickupPoint;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        Row(
            children: [
              BackButton(color: Colors.white, onPressed: (){}),
              const Spacer(),
              const Text("Route change request", textAlign: TextAlign.center),
              const Spacer(),
          ]),
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
                children:[
                  Container(
                      color: Colors.greenAccent,
                      child: Column(children:[

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.greenAccent),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Route 1", style: TextStyle(fontSize: 20)),
                                  Text("0/40", style: TextStyle(fontSize: 20)),
                                ]),
                            onPressed: () {
                              setState(() {
                                route1 = !route1;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: route1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 1"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 2"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 3"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                      )),

                  Container(
                      color: Colors.greenAccent,
                      child: Column(children:[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.greenAccent),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Route 2", style: TextStyle(fontSize: 20)),
                                  Text("20/42", style: TextStyle(fontSize: 20)),
                                ]),
                            onPressed: () {
                              setState(() {
                                route2 = !route2;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: route2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 1"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 2"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 3"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                      )),

                  Container(
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
                                children: const [
                                  Text("Route 3", style: TextStyle(fontSize: 20)),
                                  Text("26/42", style: TextStyle(fontSize: 20)),
                                ]),
                            onPressed: () {
                              setState(() {
                                route3 = !route3;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: route3,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 1"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 2"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text("Pickup point 3"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                      )),
                ]
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
                    DatePicker.showDatePicker(context, onChanged: (date){});
                  });
                },
              ),
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: (){},
                style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)),
              child: const Text(
                "Done!",
                style: TextStyle(color: Colors.white),),
            ),
        ]
        )
      )
    );
  }

}