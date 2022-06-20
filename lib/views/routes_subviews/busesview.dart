import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';
import '../../data/data.dart';

class BusesView extends StatefulWidget {
  @override
  _BusesViewState createState() => _BusesViewState();
}

class _BusesViewState extends State<BusesView> {
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
    Widget data = await buildDatatable();
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
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                height: screenHeight * 0.1,
                child: const Center(child: Text('filters1')),
              ),
              dataTable,
              EditMode(),
            ],
          ),
        ),
      ),
    ]);
  }

  Future<Widget> buildDatatable() async {
    final columns = [
      'Bus no',
      'Capacity',
      'Driver ID',
    ];
    List<Map> busResponses = await SqlDb().getAllBusses();
    print( 'Rows: ${busResponses.length}' );
    return DataTable(columns: getColumns(columns), rows: getRows(busResponses));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Map> buses) {
    return buses.map((Map Bus) {
      final cells = [
        Bus['Bus_no'].toString(),
        Bus['capacity'].toString(),
        Bus['driver_id'].toString(),
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
