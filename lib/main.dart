import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(), 
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    ); 
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() {
    return _MyStatefulWidgetState();
  }

}

enum User_Type { Admin, Passenger, Driver }
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Choose User Type!',
                  style: TextStyle(fontSize: 20),
                )),


            ListTile(
            title: const Text('Admin'),
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
          ListTile(
            title: const Text('Passenger'),
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
          ListTile(
              title: const Text('Driver'),
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
              padding: const EdgeInsets.all(10),
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
                height: 50,
                width: 450,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login',style: TextStyle(fontSize: 20)),
                  onPressed: !userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate() ? null :() {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data ' )), //+ inputtedValue!
                  );
                },
                )
            ),
          ],
        )),

        Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: ()
                    {Navigator.push(context, MaterialPageRoute(builder: (context) {return const SignupPage();}));
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),

          ],
        ));
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                  child: const Text('Continue',style: TextStyle(fontSize: 20)),
                  onPressed: !userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate() ? null :() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {return const PassengerSignupPage();}));

                },
                )
            ),
          ],
        )),

          Row(
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
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            

          ],
        ))
        ],
    ));
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class PassengerSignupPage extends StatefulWidget {
  const PassengerSignupPage({Key? key}) : super(key: key);
 
  @override
  _PassengerSignupPage createState() {
    return _PassengerSignupPage();
  }
}

class _PassengerSignupPage extends State<PassengerSignupPage> {
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
                  child: const Text('Continue',style: TextStyle(fontSize: 20)),
                  onPressed: !userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate() ? null :() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {return const DriverHomaPage();}));

                },
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



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DriverHomaPage extends StatefulWidget {
  const DriverHomaPage({Key? key}) : super(key: key);
 
  @override
  State<DriverHomaPage> createState() => _DriverHomaPage();
}

class _DriverHomaPage extends State<DriverHomaPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(title: const Text("")), body:
    Column(children: <Widget>[ 
        Expanded(child: ListView(
          
          children: <Widget>[

            Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child:Image.asset('assets/images/user.png', height: 130,
            width: 130,)),    

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Your Name',
                  style: TextStyle(fontSize: 18),
                )),

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Your Email address',
                  style: TextStyle(fontSize: 15),
                )),   

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Your phone address',
                  style: TextStyle(fontSize: 15),
                )),      


            Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Container(
              
            width: 150.0,
            height: 150.0,
            decoration: new BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            ),
            child: ElevatedButton(
                  child: Center( child: const Text(
                  'Current route',style: TextStyle(fontSize: 20))),
                  style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  
                ), 
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {return const NoRouteYet();}));
                  },),
                
          )),    

                            
          ],
        ))
        ],
    ));
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class NoRouteYet extends StatefulWidget {
  const NoRouteYet({Key? key}) : super(key: key);
 
  @override
  State<NoRouteYet> createState() => _NoRouteYet();
}

class _NoRouteYet extends State<NoRouteYet> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(title: const Text("")), body:
    Column(children: <Widget>[ 
        Expanded(child: ListView(
          
          children: <Widget>[

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(110, 200, 90, 0),
                child: const Text(
                  'Your admin has not assigned you a route yet, please contact them!',
                  style: TextStyle(fontSize: 25),
                )),

            Padding(
            padding: const EdgeInsets.fromLTRB(80, 40, 80, 0),
            child: Container(
              
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
            color: Colors.blue,
            ),
            child: ElevatedButton(
                  child: Center( child: const Text(
                  'Okay', style: TextStyle(fontSize: 20))),
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {return const CurrentRoute();}));
                  },),
                
          )),

                            
          ],
        ))
        ],
    ));
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CurrentRoute extends StatefulWidget {
  const CurrentRoute({Key? key}) : super(key: key);
 
  @override
  State<CurrentRoute> createState() => _CurrentRoute();
}

class _CurrentRoute extends State<CurrentRoute> {
  
  String descText1 = "Pickup point 1\nPickup point 2\nPickup point 3\nPickup point 4\nPickup point 5\nPickup point 6";
  String descText2 = "Passenger name 1\nPassenger name 2\nPassenger name 3\nPassenger name 4\nPassenger name 5\nPassenger name 6";

bool descTextShowFlag = false;
bool descTextShowFlag2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route ID"),
      ),
      body: Column(children: <Widget>[

        Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                child: const Text(
                  'Description',
                  style: TextStyle(fontSize: 20),
                )),
        
        Container(
              
            width: 450.0,
            height: 50.0,
            decoration: new BoxDecoration(
            color: Colors.blue,
            ),
            child: ElevatedButton(
                  child: const Text('Pickup Points',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                  },
                ),),

        new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(descText1,
                maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start),
              InkWell(
                onTap: (){ setState(() {
                descTextShowFlag = !descTextShowFlag; 
                }); },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    descTextShowFlag ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
                  ],
                ),
              ),
          ],
        ),
),

            Container(
            width: 450.0,
            height: 50.0,
            decoration: new BoxDecoration(
            color: Colors.blue,
            ),
            child: ElevatedButton(
                  child: const Text('Passengers',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                  },
                ),),


            new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(descText2,
                maxLines: descTextShowFlag2 ? 8 : 2,textAlign: TextAlign.start),
              InkWell(
                onTap: (){ setState(() {
                descTextShowFlag2 = !descTextShowFlag2; 
                }); },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    descTextShowFlag2 ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
                  ],
                ),
              ),
          ],
        ),
),



          ElevatedButton(
                  child: const Text('Start Route',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {return const StartedCurrentRoute();}));
                  },
                ),

]));
}
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class StartedCurrentRoute extends StatefulWidget {
  const StartedCurrentRoute({Key? key}) : super(key: key);
 
  @override
  State<StartedCurrentRoute> createState() => _StartedCurrentRoute();
}

class _StartedCurrentRoute extends State<StartedCurrentRoute> {
  
  String descText1 = "Pickup point 1\nPickup point 2\nPickup point 3\nPickup point 4\nPickup point 5\nPickup point 6";
  String descText2 = "Passenger name 1\nPassenger name 2\nPassenger name 3\nPassenger name 4\nPassenger name 5\nPassenger name 6";

bool descTextShowFlag = false;
bool descTextShowFlag2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route ID"),
      ),
      body: Column(children: <Widget>[

        Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                child: const Text(
                  'Description',
                  style: TextStyle(fontSize: 20),
                )),
        
        Container(
              
            width: 450.0,
            height: 50.0,
            decoration: new BoxDecoration(
            color: Colors.blue,
            ),
            child: ElevatedButton(
                  child: const Text('Pickup Points',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                  },
                ),),

        new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(descText1,
                maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start),
              InkWell(
                onTap: (){ setState(() {
                descTextShowFlag = !descTextShowFlag; 
                }); },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    descTextShowFlag ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
                  ],
                ),
              ),
          ],
        ),
),

            Container(
            width: 450.0,
            height: 50.0,
            decoration: new BoxDecoration(
            color: Colors.blue,
            ),
            child: ElevatedButton(
                  child: const Text('Passengers',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                  },
                ),),


            new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(descText2,
                maxLines: descTextShowFlag2 ? 8 : 2,textAlign: TextAlign.start),
              InkWell(
                onTap: (){ setState(() {
                descTextShowFlag2 = !descTextShowFlag2; 
                }); },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    descTextShowFlag2 ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
                  ],
                ),
              ),
          ],
        ),
),



          ElevatedButton(
                  child: const Text('Advance Pickup Point',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                  },
                ),

]));
}
}