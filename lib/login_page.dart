import 'package:flutter/material.dart';
import 'package:gui/signup_page.dart';
import 'package:gui/sql_db.dart';

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
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            //ScaffoldMessenger.of(context).showSnackBar(
                            //  const SnackBar(content: Text('Processing Data ' )), //+ inputtedValue!
                            //)
                            //Future<List<Map>> db = readData();
                            //List<Map> response = await sqlDb.readData("select * from User_Table");
                            List<Map> response = await sqlDb.readData("select privilage from User_Table WHERE username= '${usernameController.text}' and password= '${passwordController.text}' ");
                            //List<Map> response2 = response.where((response) => response["privilage"]
                            //.toList();
                            print(response);
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
                  onPressed: () 
                  {Navigator.push(context, MaterialPageRoute(builder: (context) {return const SignupPage();}));
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
