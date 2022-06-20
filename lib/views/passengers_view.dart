import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widgets/scrollable_widget.dart';

class PassengersView extends StatefulWidget {
  @override
  _PassengersViewState createState() => _PassengersViewState();
}

class _PassengersViewState extends State<PassengersView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;
  List<Passenger> selected = [];

  String dropdownvalue = 'Route_ID 1';
  String dropdownvalue2 = 'ID1';
  // List of items in our dropdown menu
  var routes_items = [
    'Route_ID 1',
    'Route_ID 2',
    'Route_ID 3',
    'Route_ID 4',
    'Route_ID 5',
  ];

  var ids_items = [
    'ID1',
    'ID2',
    'ID3',
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    viewHeight = screenHeight * 0.8;
    viewWidth = MediaQuery.of(context).size.width;
    return desktopView();
  }

  Widget desktopView() {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                  height: screenHeight * 0.1,
                  width: viewWidth * 0.5,
                  child: Row(children: <Widget>[
                    const Text('Filter:     ',
                        style: (TextStyle(fontSize: 20, color: Colors.grey))),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      //theme
                      dropdownColor: Color.fromARGB(255, 146, 137, 139),
                      style: TextStyle(
                          fontSize: 17, color: Colors.white, height: 1.25),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: routes_items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    // const Spacer(),
                    SizedBox(
                      width: 40,
                    ),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue2,
                      //theme
                      dropdownColor: Color.fromARGB(255, 146, 137, 139),
                      style: TextStyle(
                          fontSize: 17, color: Colors.white, height: 1.25),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: ids_items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue2 = newValue!;
                        });
                      },
                    )
                  ])),
              Container(
                height: screenHeight * 0.05,
              ),
              Expanded(child: ScrollableWidget(child: buildDatatable())),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildDatatable() {
    final columns = [
      'no',
      'Name',
      'ID',
      'Email',
      'Pickup point',
      'Passenger contact',
      'Emergency contact',
      'Route'
    ];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(allPASSENGERS),
      headingTextStyle: TextStyle(fontSize: 20, color: Colors.grey[500]),
      dataTextStyle:
          const TextStyle(fontSize: 17, color: Colors.white, height: 1.25),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Passenger> Passengers) {
    return Passengers.map((Passenger Passenger) {
      final cells = [
        Passenger.no,
        Passenger.Name,
        Passenger.Id,
        Passenger.Email,
        Passenger.Pickup_point,
        Passenger.Passenger_contact,
        Passenger.Emergency_contact,
        Passenger.Route,
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
