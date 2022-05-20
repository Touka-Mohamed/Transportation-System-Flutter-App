import 'package:flutter/material.dart';
import 'package:gui/homepage.dart';
import 'package:gui/login_page.dart';
import 'package:gui/route_change_request_page.dart';
import 'package:gui/views/passengers_view.dart';
import 'package:gui/views/payment_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'ZC Transportation System';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: _title,
      home:  PassengersView(), 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}