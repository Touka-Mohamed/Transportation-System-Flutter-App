// import 'dart:html';
import 'package:flutter/material.dart';
import 'content_view.dart';
import 'views/inbox_view.dart';
import 'views/home_view.dart';
import 'views/maintenance_view.dart';
import 'views/passengers_view.dart';
import 'views/payment_view.dart';

import 'views/routes_view.dart';
import 'widgets/custom_tab.dart';

// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  // late ItemScrollController itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;
  late double topPadding;
  late double bottomPadding;
  late double sidePadding;

  List<ContentView> contentViews = [
//main menue==============================================================================
    ContentView(
      tab: CustomTab(title: 'Home'),
      content: HomeView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Payment'),
      content: PaymentView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Passengers'),
      content: PassengersView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Routes'),
      content: const RoutesView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Inbox'),
      content: InboxView(),
    ),
    ContentView(
      tab: CustomTab(title: 'Maintenance'),
      content: MaintenanceView(),
    )
  ];
//end main menue===================================================================================
  // @override
  // void initState() {
  //   super.initState();
  //   // itemScrollController = ItemScrollController();
  // }

  @override
  Widget build(BuildContext context) {
    //=============================================================================
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.03;
    sidePadding = screenWidth * 0.05;
    // print('Width: $screenWidth');
    // print('Height: $screenHeight');
    return DefaultTabController(
        length: contentViews.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.1),
            child: AppBar(
              bottom: TabBar(
                  isScrollable: true,
                  tabs: contentViews.map((e) => e.tab).toList()),
            ),
          ),
          backgroundColor: const Color(0xff1e1e24),
          key: scaffoldKey,
          body: Padding(
            padding: EdgeInsets.zero,
            child: TabBarView(
                children: contentViews.map((e) => e.content).toList()),
          ),
        ));
  }

  Widget S() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Tab Bar
        SizedBox(
          height: screenHeight * 0.05,
          width: screenWidth,
          //color: Color(0xff1e1e24),
        ),
      ],
    );
  }
}
