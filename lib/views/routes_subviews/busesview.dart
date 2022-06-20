import 'package:flutter/material.dart';
import 'package:gui/data/controller.dart';
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
<<<<<<< Updated upstream
=======

    // _selected = List<bool>.generate(allBUSES.length, (int index) => false);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
              Container(
                height: screenHeight * 0.1,
                child: Center(child: Text('filters1')),
              ),
              buildDatatable(),
              EditMode(),
=======
              Expanded(child: ScrollableWidget(child: buildDatatable())),
              EditMode(),
              SizedBox(height: 12),
              Addbtn(),
              SizedBox(height: 12),
              deletebtn(),
>>>>>>> Stashed changes
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
    ];
<<<<<<< Updated upstream
    return DataTable(columns: getColumns(columns), rows: getRows(allBUSES));
=======
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(allBUSES),
      headingTextStyle: TextStyle(fontSize: 20, color: Colors.grey[500]),
      dataTextStyle:
          const TextStyle(fontSize: 17, color: Colors.white, height: 1.25),
    );
>>>>>>> Stashed changes
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<Bus> buses) {
<<<<<<< Updated upstream
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
=======
    // return buses.map((Bus Bus) {
    return buses
        .map((Bus Bus) => DataRow(
              // return buses.mapIndexed((index, Bus) => DataRow(
              selected: selected.contains(Bus),
              onSelectChanged: (isSelected) => setState(() {
                final isAdding = isSelected != null && isSelected;

                isAdding ? selected.add(Bus) : selected.remove(Bus);
              }),
              // final cells = [
              //   Bus.Route,
              //   Bus.Bus_no,
              //   Bus.Capacity,
              //   Bus.DriverName,
              //   Bus.Driver_contact,
              //   Bus.Select
              // ];
              cells: [
                _createdynamicCell(Text(Bus.Route)),
                _createdynamicCell(Text(Bus.Bus_no)),

                ////
                _createdynamicCell(Text(Bus.Capacity)),
                _createdynamicCell(Text(Bus.DriverName)),
                _createdynamicCell(Text(Bus.Driver_contact)),
                // DataCell(Text(Bus.Select)),
              ],
              //         selected: _selected[index],
              //         onSelectChanged: (bool? selected) {
              //           setState(() {
              //             _selected[index] = selected!;
              //           });
              //         }))
              // .toList();

              // return DataRow(cells: getCells(cells));
              // // return buses.map((index, cells) => DataRow(cells: getCells(cells)));
            ))
        .toList();
>>>>>>> Stashed changes
  }

  bool? _isEditMode = false;
  List<DataCell> getCells(List<dynamic> cells) =>
      // cells.map((data) => DataCell(Text('$data'))).toList();
      cells.map((data) => _createdynamicCell(data)).toList();

  DataCell _createdynamicCell(data) {
    return DataCell(_isEditMode == true
        ? TextFormField(
<<<<<<< Updated upstream
            initialValue: data,
            style: TextStyle(
=======
            initialValue: "${data}",
            style: const TextStyle(
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        Text('Edit mode'),
      ],
    );
  }
=======
        const Text('Edit mode', style: (TextStyle(color: Colors.white))),
      ],
    );
  }

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
                  //
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
          final TextEditingController Route_text = TextEditingController();
          final TextEditingController Bus_no_text = TextEditingController();
          final TextEditingController Capacity_text = TextEditingController();
          final TextEditingController Driver_Name_text =
              TextEditingController();
          final TextEditingController Driver_Contact_text =
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
                        controller: Route_text,
                        maxLength: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid Field';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Route   eg:S3"),
                      ),
                      TextFormField(
                        controller: Bus_no_text,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter Bus no   eg: ن ط ب 395"),
                      ),
                      TextFormField(
                        controller: Capacity_text,
                        // validator: (value) {
                        //   return value!.isNotEmpty ? null : "Invalid Field";
                        // },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 2 ||
                              (!(RegExp(r'^-?[0-9]+$').hasMatch(value)))) {
                            return 'Invalid Field';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Bus Capacity"),
                      ),
                      TextFormField(
                        controller: Driver_Name_text,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration:
                            const InputDecoration(hintText: "Driver Name"),
                      ),
                      TextFormField(
                        controller: Driver_Contact_text,
                        maxLength: 11,
                        // validator: (value) {
                        //   return value!.isNotEmpty ? null : "Invalid Field";
                        // },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 11 ||
                              (!(RegExp(r'^-?[0-9]+$').hasMatch(value)))) {
                            return 'Invalid Field';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Driver Contact "),
                      ),
                      ////
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Done'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.

                      // @override
                      // Future<void> insert() async => await
                      controllerobj.InsertBus(
                          Route_text.text,
                          Bus_no_text.text,
                          int.parse(Capacity_text.text),
                          Driver_Name_text.text,
                          int.parse(Driver_Contact_text.text));
                      // insert();

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

  //==================================
  /////////////////////////////////
  ///

>>>>>>> Stashed changes
}
