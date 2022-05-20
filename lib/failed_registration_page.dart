import 'package:flutter/material.dart';

class FailedRegistrationPage extends StatefulWidget
{
  const FailedRegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FailedRegistrationPageState();
}

class FailedRegistrationPageState extends State<FailedRegistrationPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
          child: Column
            (
            children: [
              const Spacer(),
              const Text("Error, Not the user's bus",
                style: TextStyle(
                    fontSize: 34,
                color: Colors.white
                )
              ),
              const Spacer(),
              SizedBox(
                width: 200,
                height: 50,
                child: TextButton(
                  onPressed: (){},
                  child: const Text(
                    "Okay!",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  ),
                ),
              ),
              const Spacer(),
            ],
          )
      ),
    );
  }

}