import 'package:flutter/material.dart';
import 'package:gui/current_route.dart';
import 'package:gui/file_complaint_page.dart';
import 'package:gui/qr_code_page.dart';
import 'package:gui/route_change_request_page.dart';
import 'package:gui/sql_db.dart';
import 'package:gui/widgets/sectioned_circle.dart';

import 'current_routes_user_page.dart';
import 'no_route_yet.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key, required this.name, required this.mobileNo, required this.email}) : super(key: key);
  String name;
  int mobileNo;
  String email;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Icon(Icons.account_circle, size: 64),
            Text(
              widget.name,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(widget.email,
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            Text(widget.mobileNo.toString(),
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            const Spacer(),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                //Complaint
                SizedBox(
                  width: 240,
                  height: 240,
                  child: SectionedCircleButton(
                    color: Colors.grey,
                    gap: 5,
                    radius: 120,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FileComplaintPage()));
                    },
                    text:"Complain",
                  ),
                ),
                //Current Route
                SizedBox(
                  width: 240,
                  height: 240,
                  child: SectionedCircleButton(
                    startAngle: 120,
                    color: Colors.grey,
                    gap: 5,
                    radius: 120,
                    onTap: () async {
                      List<Map> passengerResponse = await sqlDb.getPassengerData(Globals.Instance.nationalID.toString());
                      String? routeID = passengerResponse[0]['Route_id'];
                      if(routeID == null || routeID.isEmpty)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentRoutesUserPage()));
                      }
                      else
                      {
                        List<Map> routeResponse = await sqlDb.getRouteData(routeID);
                        String route_title = routeResponse[0]['title'].toString();
                        String semester = routeResponse[0]['semester'].toString();
                        int year = routeResponse[0]['year'];
                        String bus_num = routeResponse[0]['bus_no'].toString();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentRoute(routeid: routeID, route_title: route_title, semester: semester, year: year, bus_num: bus_num)));
                      }
                    },
                    text: "Current Route",
                  ),
                ),
                //Request Route Change
                SizedBox(
                  width: 240,
                  height: 240,
                  child: SectionedCircleButton(
                    startAngle: 240,
                    color: Colors.grey,
                    gap: 5,
                    radius: 120,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RouteRequestChangePage()));
                    },
                    text:  "Request Route Change",
                  ),
                ),
                //Qr code button
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QRCodePage()));
                    },
                    child: const Text(
                      "Scan QR Code",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}