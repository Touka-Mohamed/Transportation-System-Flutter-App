import 'dart:js_util';

import 'package:flutter/material.dart';

enum SelectOptions { exceptions, complains }

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InboxPageState();
}

class InboxPageState extends State<InboxPage> {
  int? selectedRoute;
  int? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey,
        ),
        Container(
          width: 3 * MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height,
          color: Colors.greenAccent,
          child: Column(
            children: [
              // Filters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Filter"),
                  DropdownButton<int>(
                    value: selectedDay,
                    items: const [
                      DropdownMenuItem(child: Text("Day"),),
                      DropdownMenuItem(value: 1, child: Text("Today")),
                      DropdownMenuItem(value: 2, child: Text("Tomorrow")),
                    ],
                    onChanged: (value) {print(value); selectedDay = value;},
                  ),
                  DropdownButton<int>(
                    value: selectedRoute,
                    items: const [DropdownMenuItem(child: Text("Route"))],
                    onChanged: (value) {print(value); selectedRoute = value;},
                  ),
                  ElevatedButton(
                      onPressed: () {
                        selectedDay = 0;
                        selectedRoute = 0;
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (state) => Colors.transparent),
                        shadowColor: MaterialStateColor.resolveWith(
                            (state) => Colors.transparent),
                      ),
                      child: const Icon(Icons.remove_circle_outline)),
                ],
              ),
              // Objects
              const ComplaintItem(
                title: "valorant",
                route: "Haram",
              ),
              const ComplaintItem(
                title: "Ezat",
              ),
              ComplaintItem(
                title: "خرا",
                date: DateTime.now(),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

class ComplaintItem extends StatelessWidget {
  final String complaintID;
  final String complaintText;
  final String title;
  final String route;
  final DateTime? date;

  const ComplaintItem({
    Key? key,
    this.complaintID = "515863452",
    this.route = "Route",
    this.date,
    this.title = "Title",
    this.complaintText = "ربنا ما يجيب شكوي ان شاء الله"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        width: MediaQuery.of(context).size.width,
        height: 140,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.message_sharp,
                  size: 20,
                  color: Colors.blue,
                ),
                Text(title),
                Text(route),
                Text("${date?.year} - ${date?.month} - ${date?.day}")
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.grey,
              child: Wrap(
                spacing: 5,
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.down,
                runAlignment: WrapAlignment.start,
                children: [
                  Text(
                    complaintID,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    complaintText,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
