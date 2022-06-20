import 'package:flutter/material.dart';
import '../data/data.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;

  String dropdownvalue = 'Route_ID 1';   
  String dropdownvalue2= 'ID1';
  String dropdownvalue_status= 'True';

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

  var status_items = [    
    'True',
    'False',
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
        body:
      Center(
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight * 0.05,
            ),
            SizedBox(
                height: screenHeight * 0.1,
                width: viewWidth*0.3,
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
            ),

            const Spacer(),
            
            DropdownButton(
              // Initial Value
              value: dropdownvalue_status,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
              // Array list of items
              items: status_items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue_status = newValue!;
                });
              },
            )
            ])),



            buildDatatable(),
          ],
        ),
      )),
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
