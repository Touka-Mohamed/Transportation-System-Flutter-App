import 'package:flutter/material.dart';
import 'package:gui/passenger_signup_page.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPage createState() {
    return _SignupPage();
  }
}

class _SignupPage extends State<SignupPage> {
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
              child: ListTile(contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
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
                        onPressed: !userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate() ? null :() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {return const PassengerSignupPage();}));

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