import 'package:flutter/material.dart';
import 'package:gui/data/database.dart';
import 'package:gui/widgets/scrollable_widget.dart';
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
                    const Text('Filter:     ',
                        style: (TextStyle(fontSize: 20, color: Colors.grey))),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      //theme
                      dropdownColor: Color.fromARGB(255, 146, 137, 139),
                      style: TextStyle(
                          fontSize: 17, color: Colors.white, height: 1.25),
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
              Expanded(child: ScrollableWidget(child: dataTable)),
              Addbtn(),
            ],
          ),
        ),
      ),
    ]);
  }

  Future<Widget> buildDatatable() async {
    final columns = ['Route', 'order no', 'Address', 'Time '];
    List<Map> PickUpPoints = await database().getAllPickupPoints();
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(PickUpPoints),
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

  List<DataRow> getRows(List<Map> PickUpPoints) {
    return PickUpPoints.map((Map pickUpPoint) {
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInputDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController Route_id_text = TextEditingController();
          final TextEditingController order_no_text = TextEditingController();
          final TextEditingController address_text = TextEditingController();
          TimeOfDay time = TimeOfDay.now();

          void _showtimepicker() {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((value) {
              setState(() {
                time = value!;
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
                        controller: Route_id_text,
                        maxLength: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid Field';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Route    eg:S3"),
                      ),
                      TextFormField(
                        controller: order_no_text,
                        maxLength: 2,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              (!(RegExp(r'^-?[0-9]+$').hasMatch(value)))) {
                            return 'Invalid Field';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "number of pickup point   "),
                      ),
                      TextFormField(
                        controller: address_text,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter Address   eg:الفردوس"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: _showtimepicker,
                        child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Select time',
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
                      await database().addPickUpPoint(
                          address_text.text,
                          int.parse(order_no_text.text),
                          Route_id_text.text,
                          time.toString());

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
}
