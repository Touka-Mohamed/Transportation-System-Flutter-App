import 'package:flutter/material.dart';
import 'package:gui/driver_homepage.dart';
import 'package:gui/homepage.dart';
import 'package:gui/signup_page.dart';
import 'package:gui/sql_db.dart';
import 'package:gui/user_homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  SqlDb sqlDb = SqlDb(); //instance of the database class

  //Future<List<Map>> readData() async {
  //  List<Map> response = await sqlDb.readData("select * from User_Table");
  // print(response);
  //return response;
  // }

  final _formKey = GlobalKey<FormState>();
  // recording fieldInput
  String? inputtedValue;

  // you can add more fields if needed
  bool userInteracts() => inputtedValue != null;
  bool _passwordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ZC Transportation System')),
        body: 
      Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: usernameController,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (inputtedValue != null &&
                                (value == null || value.isEmpty)) {
                              return 'Please enter a valid username';
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => inputtedValue = value),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !_passwordVisible,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (inputtedValue != null &&
                                (value == null || value.isEmpty)) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => inputtedValue = value),
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 450,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            onPressed: !userInteracts() ||
                                    _formKey.currentState == null ||
                                    !_formKey.currentState!.validate()
                                ? null
                                : () async {
                                    List<Map> response = await sqlDb.readData(
                                        "select * from User_Table WHERE username= '${usernameController.text}' and password= '${passwordController.text}' ");
                                    print(response);
                                    String name;
                                    int phone;
                                    int national_id;
                                    if (response.length == 0) {
                                      print("incorrect username or password");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Incorrect Username or Password')) //+ inputtedValue!
                                          );
                                    } else {
                                      name = response[0]['name'].toString();
                                      phone = response[0]['phone_number'];
                                      national_id = response[0]['national_id'];
                                      if (response[0]['privilage'] == 3) {
                                        //if driver

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DriverHomePage(
                                                        name: name,
                                                        phone: phone,
                                                        national_id: national_id,
                                                        )
                                            )
                                        );
                                      } else if (response[0]['privilage'] == 2) {
                                        //if passenger

                                        List<Map> passengerResponse = await sqlDb.readData(
                                            "select * from Passenger WHERE NationalID= '$national_id'");
                                        String email = passengerResponse[0]['Email'].toString();
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UserHomePage(
                                            name: name,
                                            mobileNo: phone,
                                            email: email
                                          );
                                        }));
                                      } else if (response[0]['privilage'] == 1) {
                                        //if admin
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AdminHomePage();
                                        }));
                                      }
                                    }
                                  },
                            child: const Text('Login',
                                style: TextStyle(fontSize: 20)),
                          )),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignupPage();
                      }));
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}
