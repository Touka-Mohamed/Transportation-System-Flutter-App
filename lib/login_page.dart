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
  bool _passwordVisible=false;
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
        child: ListView(
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
                        controller: passwordController,
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
                          onPressed: !userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate() ? null : ()  async{

                            List<Map> response = await sqlDb.readData("select * from User_Table WHERE username= '${usernameController.text}' and password= '${passwordController.text}' ");
                            print(response);
                            if (response.length == 0) {
                              print("incorrect username or password");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Incorrect Username or Password' )) //+ inputtedValue!
                                );
                            }
                            else if (response[0]['privilage'] == 3) { //if driver
                              int nationalid=response[0]['national_id'];
                              String namee=response[0]['name'];
                              int phonee=response[0]['phone_number'];
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHomePage(name: namee, phone:phonee, natioanlId: nationalid) ));
                            }
                            else if (response[0]['privilage'] == 2) { //if passenger3

                              Navigator.push(context, MaterialPageRoute(builder: (context) {return const UserHomePage();}));

                            }
                            else if (response[0]['privilage'] == 1) {  //if admin
                              Navigator.push(context, MaterialPageRoute(builder: (context) {return const AdminHomePage();}));
                            }
                          },
                          child: const Text('Login',style: TextStyle(fontSize: 20)),
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
                  onPressed: () async
                  {
                    //await sqlDb.mydeleteDatabase();
                  // int response = await sqlDb.insertData("""
                  //       INSERT INTO Route ('Route_id', 'semester', 'year')
                  //        VALUES ("2", "1", 2) """)  ;
                  //  print(response);


                    Navigator.push(context, MaterialPageRoute(builder: (context) {return const SignupPage();}));
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),

          ],
        )));
  }
}
