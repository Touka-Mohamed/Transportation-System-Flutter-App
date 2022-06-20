import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';
import '../../data/data.dart';

class PassengersView extends StatefulWidget {
  @override
  _PassengersViewState createState() => _PassengersViewState();
}

class _PassengersViewState extends State<PassengersView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;

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
                    const Spacer(),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue2,
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
              dataTable,
            ],
          ),
        ),
      ),
    ]);
  }

  Future<Widget> buildDatatable() async{
    final columns = [
      'Email',
      'NationalID',
      'UST ID',
      'Payment Date',
      'Route ID',
      'Pick up point',
      'Approval'
    ];
    print('Columns: ${columns.length}');
    List<Map> passengerResponse = await SqlDb().getAllPassengers();
    print('Rows: ${passengerResponse.length}');
    return DataTable(columns: getColumns(columns), rows: getRows(passengerResponse));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Map> passengers) {
    return passengers.map( (Map passenger) {
      final cells = [
        passenger['Email'],
        passenger['NationalID'],
        passenger['UST_id'],
        passenger['Payment_date'],
        passenger['Route_id'],
        passenger['Pick_up_Point_order_number'],
        passenger['Approval']
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
