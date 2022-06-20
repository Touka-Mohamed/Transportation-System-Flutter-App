import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../content_view.dart';
import '../data/data.dart';
import '../widgets/custom_tab.dart';
import 'routes_subviews/attendance_log_view.dart';
import 'routes_subviews/busesview.dart';
import 'routes_subviews/pickup_points_view.dart';
import 'routes_subviews/tripsview.dart';

class RoutesView extends StatefulWidget {
  const RoutesView({Key? key}) : super(key: key);
  @override
  _RoutesViewState createState() => _RoutesViewState();
}

class _RoutesViewState extends State<RoutesView>
    with SingleTickerProviderStateMixin {
  late ItemScrollController itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late double screenHeight;
  late double viewHeight;
  late double viewWidth;
  late double topPadding;
  late double bottomPadding;
  late double sidePadding;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    viewHeight = screenHeight * 0.8;
    viewWidth = MediaQuery.of(context).size.width;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.03;
    sidePadding = viewWidth * 0.05;
    return DefaultTabController(
        length: subcontentViews.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.1),
            child: AppBar(
              bottom: TabBar(
                  isScrollable: true,
                  tabs: subcontentViews.map((e) => e.tab).toList()),
              backgroundColor: Colors.grey,
            ),
          ),
          key: scaffoldKey,
          //endDrawer: drawer(),
          body: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: TabBarView(
                children: subcontentViews.map((e) => e.content).toList()),
          ),
        ));
  }

  Widget desktopView() {
    return Stack(children: [
      Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Container(height: screenHeight * 0.05),
              SizedBox(
                height: screenHeight * 0.1,
                child: const Center(child: Text('filters')),
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

//////////////////////////////////////submenue///////////////////////////////////////////////
  List<ContentView> subcontentViews = [
    ContentView(
      tab: CustomTab(title: 'Buses'),
      content: BusesView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Pickup Points'),
      content: PickupPointsView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Trips'),
      content: TripsView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Attendance Log'),
      content: AttendanceLogView(),
    ),
  ];
///////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
  }

  Widget subviews() {
    return Padding(
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Stack(
        children: [
          subcontentViews[index].content,
          IconButton(
              iconSize: viewWidth * 0.03,
              icon: const Icon(Icons.menu_rounded),
              color: Colors.white,
              splashColor: Colors.transparent,
              onPressed: () => scaffoldKey.currentState!.openEndDrawer()),
        ],
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return SizedBox(
      width: viewWidth * 0.3,
      child: Drawer(
        child: ListView(
          children: [Container(height: screenHeight * 0.1)] +
              subcontentViews
                  .map((e) => Container(
                        child: ListTile(
                            title: Text(
                              e.tab.title,
                              style: Theme.of(context).textTheme.button,
                            ),
                            onTap: () {
                              setState(() {
                                index:
                                subcontentViews.indexOf(e);
                              });
                              print(index);
                            }),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}