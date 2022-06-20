import 'package:flutter/material.dart';

import 'driver_homepage.dart';

class PassengerSignupPage extends StatefulWidget {
  const PassengerSignupPage({Key? key}) : super(key: key);

  @override
  PassengerSignupPageState createState() {
    return PassengerSignupPageState();
  }
}

class PassengerSignupPageState extends State<PassengerSignupPage> {
  final _formKey = GlobalKey<FormState>();
  // recording fieldInput
  String? inputtedValue;

  // you can add more fields if needed
  bool userInteracts() => inputtedValue != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(title: const Text("Sign Up")), body:
    Column(children: <Widget>[
      Expanded(child: ListView(

        children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Hey Passenger!',
                style: TextStyle(fontSize: 20),
              )),

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Enter these additional information',
                style: TextStyle(fontSize: 15),
              )),


          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty ||
                            !(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))) ) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child:TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ID',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value != null && (value.isNotEmpty) &&
                            (!(RegExp(r'^-?[0-9]+$').hasMatch(value))  )   )) {
                          return 'Please enter a valid ID';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => inputtedValue = value),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child:TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Emergency Contact',
                      ),
                      validator: (value) {
                        if (inputtedValue != null && (value == null || value.isEmpty ||
                            (!(RegExp(r'^-?[0-9]+$').hasMatch(value))  ))) {
                          return 'Please enter a valid emergency contact';
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) {return const DriverHomePage();}));

                        },
                        child: const Text('Continue',style: TextStyle(fontSize: 20)),
                      )
                  ),
                ],
              )),




        ],
      ))
    ],
    ));
  }
}