import 'package:flutter/material.dart';
import '../../data/data.dart';

class PickupPointsView extends StatefulWidget {
  @override
  _PickupPointsViewState createState() => _PickupPointsViewState();
}

class _PickupPointsViewState extends State<PickupPointsView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;

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
                width: viewWidth*0.5,
                child: 

                Row(children: <Widget>[ 

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

              buildDatatable(),
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
      'Payment Date',
      'Route',
      'Email',
      'Approval'
    ];
    return DataTable(columns: getColumns(columns), rows: getRows(allPAYMENTS));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<payment> payments) {
    return payments.map((payment payment) {
      final cells = [
        payment.no,
        payment.name,
        payment.id,
        payment.payment_date,
        payment.route,
        payment.Email,
        payment.approval
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
