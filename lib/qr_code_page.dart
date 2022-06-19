import 'package:flutter/material.dart';

class QRCodePage extends StatefulWidget
{
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QRCodePageState();
}

class QRCodePageState extends State<QRCodePage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      backgroundColor: Colors.grey,
      body: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Column
          (
          children: [
            Container(alignment: AlignmentDirectional.centerStart,child: BackButton(color: Colors.blue, onPressed: (){}),),
            const Spacer(),
            const Text("Place the QR code in this box"),
            const Spacer(),
            Container(
              width: 200,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2)
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),),
                child: const Text(
                  "Okay!",
                    style: TextStyle(color: Colors.white),),),
            ),
            const Spacer(),
          ],
        ),
      )
    );
  }

}