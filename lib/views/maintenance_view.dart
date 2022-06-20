import 'package:flutter/material.dart';
import 'package:gui/data/controller.dart';
import 'package:gui/data/database.dart';
import '../../data/data.dart';
import '../widgets/scrollable_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MaintenanceView extends StatefulWidget {
  @override
  _MaintenanceViewState createState() => _MaintenanceViewState();
}

class _MaintenanceViewState extends State<MaintenanceView> {
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;
  List<payment> selected = [];

  Widget dataTable = Container();
  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    Widget temp = await buildDatatable();
    setState(() => dataTable = temp);
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
              Expanded(child: ScrollableWidget(child: dataTable)),
              Addbtn(),
              SizedBox(height: 12),
              deletebtn(),
            ],
          ),
        ),
      ),
    ]);
  }

  Future<Widget> buildDatatable() async {
    final columns = [
      'ID',
      'Bus no',
      'Start Date',
      'End Date ',
    ];
    List<Map> Maintenances = await database().getAllMaintenance();
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(Maintenances),
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

  List<DataRow> getRows(List<Map> Maintenances) {
    return Maintenances.map((Map Maintenance) {
      final cells = [
        Maintenance['Maintenance_id'],
        Maintenance['Bus_no'],
        Maintenance['Start_time'],
        Maintenance['End_time'],
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  Row Addbtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 17, fontFamily: 'DMSerifDisplay'),
                ),
                onPressed: () async {
                  await showInputDialog(context);
                },
                child: const Text('     Add     ',
                    style: (TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row deletebtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 17, fontFamily: 'DMSerifDisplay'),
                ),
                onPressed: () async {
                  await showInputDialog2(context);
                },
                child: const Text('   Delete   ',
                    style: (TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInputDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          controller controllerobj = controller();
          final TextEditingController Maintanenanceid_text =
              TextEditingController();
          final TextEditingController Bus_no_text = TextEditingController();
          DateTime startdate = DateTime.now();
          DateTime enddate = DateTime.now();

          void _showstartdatepicker() {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(3000))
                .then((value) {
              setState(() {
                startdate = value!;
              });
            });
          }

          void _showenddatepicker() {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(3000))
                .then((value) {
              setState(() {
                enddate = value!;
              });
            });
          }

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///
                      TextFormField(
                        controller: Maintanenanceid_text,
                        maxLength: 3,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              (!(RegExp(r'^-?[0-9]+$').hasMatch(value)))) {
                            return 'Invalid Field';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Maintanance Id   eg:567"),
                      ),
                      TextFormField(
                        controller: Bus_no_text,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter Bus no   eg: ن ط ب 395"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: _showstartdatepicker,
                        child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Select Start date',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontFamily: 'DMSerifDisplay'),
                            )),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: _showenddatepicker,
                        child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Select End date',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontFamily: 'DMSerifDisplay'),
                            )),
                        color: Colors.blue,
                      ),
                      ////
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Done'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      await database().addMaintenance(
                          int.parse(Maintanenanceid_text.text),
                          Bus_no_text.text,
                          startdate.toString(),
                          enddate.toString());
                      init();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],

              ///
            );
          });
        });
  }

  Future<void> showInputDialog2(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          controller controllerobj = controller();
          final TextEditingController Maintanenanceid_text =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///
                    TextFormField(
                      controller: Maintanenanceid_text,
                      maxLength: 3,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            (!(RegExp(r'^-?[0-9]+$').hasMatch(value)))) {
                          return 'Invalid Field';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Maintanance Id   eg:567"),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Done'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or
                      await database().deleteMaintanance(
                          int.parse(Maintanenanceid_text.text));
                      init();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
