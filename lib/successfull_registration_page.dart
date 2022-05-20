import 'package:flutter/material.dart';

class SuccessfullBusRegistrationPage extends StatefulWidget
{
  const SuccessfullBusRegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SuccessfullBusRegistrationPageState();

}

class SuccessfullBusRegistrationPageState extends State<SuccessfullBusRegistrationPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
        child: Column
          (
          children: [
            const Spacer(),
            const Text("Registered in x bus successfully!",
            style: TextStyle(fontSize: 24),
            ),
            const Spacer(),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: (){},
                child: const Text(
                  "Okay!",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
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