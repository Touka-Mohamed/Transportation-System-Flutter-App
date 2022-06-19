import 'package:flutter/material.dart';
import 'package:gui/driver_homepage.dart';
import 'package:gui/homepage.dart';
import 'package:gui/passenger_signup_page.dart';
import 'login_page.dart';
import 'package:gui/sql_db.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPage createState() {
    return _SignupPage();
  }
}
  enum User_Type { Admin, Passenger, Driver }

class _SignupPage extends State<SignupPage> {
  SqlDb sqlDb = SqlDb(); //instance of the database class
  final _formKey = GlobalKey<FormState>();
  // recording fieldInput
  String? inputtedValue;

  // you can add more fields if needed
  bool userInteracts() => inputtedValue != null;
  bool _passwordVisible=false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }


  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController nationalId = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int privController=0;

  User_Type? _User_Type = User_Type.Admin;

  @override
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(title: const Text("Sign Up")), body:
    Column(children: <Widget>[
      Expanded(child: ListView(

        children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
              child: const Text(
                'Choose User Type!',
                style: TextStyle(fontSize: 15),
              )),

          Row(children: [
            Expanded(
              child: ListTile(
                  title: const Text('Admin', style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),),
                  leading: Radio<User_Type>(
                    value: User_Type.Admin,
                    groupValue: _User_Type,
                    onChanged: (User_Type? value) {
                      setState(() {
                        _User_Type = value;
                      });
                    },
                  )
              ),
            ),
            Expanded(
              child: ListTile(contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  title: const Text('Passenger',style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),),
                  leading: Radio<User_Type>(
                    value: User_Type.Passenger,
                    groupValue: _User_Type,
                    onChanged: (User_Type? value) {
                      setState(() {
                        _User_Type = value;
                      });
                    },
                  )
              ),
            ),

            Expanded(
              child: ListTile(
                  title: const Text('Driver',style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),),
                  leading: Radio<User_Type>(
                    value: User_Type.Driver,
                    groupValue: _User_Type,
                    onChanged: (User_Type? value) {
                      setState(() {
                        _User_Type = value;
                      });
                    },
                  )
              ),
            ),
          ],
          ),

          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child: TextFormField(
                      controller: username,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty)) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child:TextFormField(
                      obscureText: !_passwordVisible,
                      controller: password_controller,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty)) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child:TextFormField(
                      controller: name,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty ||
                            (RegExp(r'^-?[0-9]+$').hasMatch(value)))) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child:TextFormField(
                      controller: ageController,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty
                            ||  (!(RegExp(r'^-?[0-9]+$').hasMatch(value))  ))) {
                          return 'Please enter a valid age';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child:TextFormField(
                      controller: phoneController,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty
                            || (!(RegExp(r'^-?[0-9]+$').hasMatch(value))  ))) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),


                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child:TextFormField(
                      controller: nationalId,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'National ID',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty
                            ||  (!(RegExp(r'^-?[0-9]+$').hasMatch(value))  ))) {
                          return 'Please enter a valid national id';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                      height: 50,
                      width: 450,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        onPressed: !userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate() ? null :() async {
                          
                          if (_User_Type==User_Type.Admin) {
                              privController=1;
                              Navigator.push(context, MaterialPageRoute(builder: (context) {return const AdminHomePage();}));
                          } 
                          else if (_User_Type==User_Type.Passenger) {
                            privController=2;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerSignupPage(national_id: int.parse(nationalId.text), name: name.text, mobileNo: int.parse(phoneController.text), age: int.parse(ageController.text)) ));
                          } else if (_User_Type==User_Type.Driver) {
                            privController=3;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHomePage(name: name.text, phone:int.parse(phoneController.text), national_id: int.parse(nationalId.text)) ));
                          } else {
                            print("error");
                          }

                          int response = await sqlDb.insertData("""INSERT INTO User_Table('username','password','privilage',
                          'national_id','name','age','phone_number') 
                          VALUES ("${username.text}","${password_controller.text}","$privController" ,"${nationalId.text}", 
                          "${name.text}", "${ageController.text}", "${phoneController.text}") """)  ;
                          print(response);

                          

                        },
                        child: const Text('Continue',style: TextStyle(fontSize: 20)),
                      )
                  ),
                ],
              )),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Have an account?'),
              TextButton(
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //signup screen
                },
              )
            ],
          ),

        ],
      ))
    ],
    ));
  }
}