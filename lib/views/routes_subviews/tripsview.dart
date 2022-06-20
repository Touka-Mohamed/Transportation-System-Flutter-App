import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';
import '../../data/data.dart';

class TripsView extends StatefulWidget {
  @override
  _TripsViewState createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;

  Widget dataTable = Container();
  @override
  initState()
  {
    super.initState();
    init();
  }

  init() async
  {
    var data = await buildDatatable();
    setState( ()=> dataTable = data );
  }

  String dropdownvalue_day = '4/5/2022';
  String dropdownvalue_direction = 'To ZC';
  String dropdownvalue_route = 'Route_ID 1';

  // List of items in our dropdown menu
  var day_items = [
    '4/5/2022',
    '5/5/2022',
  ];

  var direction_items = [
    'To ZC',
    'From ZC',
  ];

  var routes_items = [
    'Route_ID 1',
    'Route_ID 2',
    'Route_ID 3',
    'Route_ID 4',
    'Route_ID 5',
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
                    const Text('Filter:     '),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue_day,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: day_items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue_day = newValue!;
                        });
                      },
                    ),
                    const Spacer(),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue_direction,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: direction_items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue_direction = newValue!;
                        });
                      },
                    ),
                    const Spacer(),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue_route,
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
                          dropdownvalue_route = newValue!;
                        });
                      },
                    )
                  ])),
              dataTable,
            ],
          ),
        ),
      ),
    ]);
  }

  Future<Widget> buildDatatable() async{
    final columns = [
      'Date',
      'Direction',
      'Route ID',
      'Bus Number',
      'Arrival Time',
    ];
    List<Map> tripsResponses = await SqlDb().getAllTrips();
    print("Trips: ${tripsResponses.length}");
    return DataTable(columns: getColumns(columns), rows: getRows(tripsResponses));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Map> trips) {
    return trips.map((Map trip) {
      final cells = [
        trip['Day'],
        trip['Direction'],
        trip['Route_id'],
        trip['Bus_no'],
        trip['time_at_university'],
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
