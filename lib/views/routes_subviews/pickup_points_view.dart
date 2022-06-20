import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';
import '../../data/data.dart';

class PickupPointsView extends StatefulWidget {
  @override
  _PickupPointsViewState createState() => _PickupPointsViewState();
}

class _PickupPointsViewState extends State<PickupPointsView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;

  Widget dataTable = Container();
  String dropdownvalue = 'Route_ID 1';
  // List of items in our dropdown menu
  var routes_items = [
    'Route_ID 1',
    'Route_ID 2',
    'Route_ID 3',
    'Route_ID 4',
    'Route_ID 5',
  ];

  @override
  initState()
  {
    super.initState();
    init();
  }

  init() async
  {
    Widget temp = await buildDatatable();
    setState( ()=> dataTable = temp );
  }

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
                      value: dropdownvalue,
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
      'Route ID',
      'Order Number',
      'Address',
      'Time'
    ];
    List<Map> pickUpPoints = await SqlDb().getAllPickupPoints();
    return DataTable(columns: getColumns(columns), rows: getRows(pickUpPoints));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Map> pickUpPoints) {
    return pickUpPoints.map((Map pickUpPoint) {
      final cells = [
        pickUpPoint['route_id'],
        pickUpPoint['order_number'],
        pickUpPoint['address'],
        pickUpPoint['time'],
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
