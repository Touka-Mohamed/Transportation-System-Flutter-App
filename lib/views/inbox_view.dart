import 'package:flutter/material.dart';
import 'package:gui/sql_db.dart';

import '../data/data.dart';

class InboxView extends StatefulWidget {
  @override
  _InboxViewState createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
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
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.05,
              ),
              Container(
                height: screenHeight * 0.1,
                child: const Center(child: Text('filters4')),
              ),
              dataTable,
            ],
          ),
        ),
      ),
    ]);
  }

  Future<Widget> buildDatatable() async{
    final columns = [
      'Complaint ID',
      'Title',
      'Description',
      'Passenger ID',
      'Route ID',
      'Date',
      'Direction',
      'Bus Number',
    ];
    List<Map> complaintRespones = await SqlDb().getAllComplaints();
    print("Complaints ${complaintRespones.length}");
    return DataTable(columns: getColumns(columns), rows: getRows(complaintRespones));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Map> complaints) {
    return complaints.map((Map complaint) {
      final cells = [
        complaint['Complain_id'],
        complaint['Title'],
        complaint['Description'],
        complaint['Passenger_id'],
        complaint['Route_id'],
        complaint['Day'],
        complaint['Direction'],
        complaint['Bus_no'],
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
