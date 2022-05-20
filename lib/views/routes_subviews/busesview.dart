import 'package:flutter/material.dart';
import '../../data/data.dart';

class BusesView extends StatefulWidget {
  @override
  _BusesViewState createState() => _BusesViewState();
}

class _BusesViewState extends State<BusesView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;

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
              Container(
                height: screenHeight * 0.1,
                child: Center(child: Text('filters1')),
              ),
              buildDatatable(),
              EditMode(),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildDatatable() {
    final columns = [
      'Route',
      'Bus no',
      'Capacity',
      'Driver Name',
      'Driver_contact',
      'Select'
    ];
    return DataTable(columns: getColumns(columns), rows: getRows(allBUSES));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Bus> buses) {
    return buses.map((Bus Bus) {
      final cells = [
        Bus.Route,
        Bus.Bus_no,
        Bus.Capacity,
        Bus.DriverName,
        Bus.Driver_contact,
        Bus.Select
      ];

      return DataRow(cells: getCells(cells));
    }).toList();
  }

  bool? _isEditMode = false;
  List<DataCell> getCells(List<dynamic> cells) =>
      // cells.map((data) => DataCell(Text('$data'))).toList();
      cells.map((data) => _createdynamicCell(data)).toList();

  DataCell _createdynamicCell(data) {
    return DataCell(_isEditMode == true
        ? TextFormField(
            initialValue: data,
            style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontFamily: 'DMSerifDisplay'))
        : Text(data));
  }

  Row EditMode() {
    return Row(
      children: [
        Checkbox(
          value: _isEditMode,
          onChanged: (value) {
            setState(() {
              _isEditMode = value;
            });
          },
        ),
        Text('Edit mode'),
      ],
    );
  }
}
