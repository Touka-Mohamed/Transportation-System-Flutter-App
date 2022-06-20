import 'package:flutter/material.dart';
import '../../data/data.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
