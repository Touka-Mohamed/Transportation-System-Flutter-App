import 'package:flutter/material.dart';

class CurrentRoutesUserPage extends StatefulWidget {
  const CurrentRoutesUserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CurrentRoutesUserPageState();
}

class CurrentRoutesUserPageState extends State<CurrentRoutesUserPage> {
  bool route1 = false;
  bool route2 = false;
  bool route3 = false;
  bool route4 = false;
  bool route5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            BackButton(color: Colors.white, onPressed: () {}),
            const Spacer(),
            const Text("Current Routes", textAlign: TextAlign.center),
            const Spacer(),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                color: Colors.greenAccent,
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
                            (states) => Colors.greenAccent),
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
                ])),
            //20/42
            Container(
                color: Colors.greenAccent,
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
                            (states) => Colors.greenAccent),
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
                ])),
            //42/42
            Container(
                color: Colors.redAccent,
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
                            (states) => Colors.redAccent),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text("Route 3", style: TextStyle(fontSize: 20)),
                            Text("42/42", style: TextStyle(fontSize: 20)),
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
                ])),
            //26/42
            Container(
                color: Colors.grey,
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
                            (states) => Colors.grey),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text("Route 4", style: TextStyle(fontSize: 20)),
                            Text("26/42", style: TextStyle(fontSize: 20)),
                          ]),
                      onPressed: () {
                        setState(() {
                          route4 = !route4;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: route4,
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
                ])),
            //26/42
            Container(
                color: Colors.lightBlueAccent,
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
                            (states) => Colors.lightBlueAccent),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text("Route 5", style: TextStyle(fontSize: 20)),
                            Text("26/42", style: TextStyle(fontSize: 20)),
                          ]),
                      onPressed: () {
                        setState(() {
                          route5 = !route5;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: route5,
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
                ])),
          ],
        ),
      ),
    );
  }
}
