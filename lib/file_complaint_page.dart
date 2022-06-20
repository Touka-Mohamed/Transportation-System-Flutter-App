import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class FileComplaintPage extends StatefulWidget
{
  const FileComplaintPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FileComplaintPageState();
}

class FileComplaintPageState extends State<FileComplaintPage>
{
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
            children: [
              BackButton(color: Colors.white, onPressed: (){}),
              const Spacer(),
              const Text("File a complaint", textAlign: TextAlign.center),
              const Spacer(),
            ]),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(
              "Title",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),
          const TextField(
            decoration: InputDecoration(hintText: "Insert title here.."),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
              onPressed: () {DatePicker.showDatePicker(context, onConfirm:(date)
              {
                setState(() {
                  selectedDate = date;
                });
              })
              ;},
              child: const Text(
                "When was that?",
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.left,
              ),

            ),

          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Text(
                selectedDate.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(
              "Description",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),
          const TextField(
              decoration: InputDecoration(hintText: "Tell us what happened here.."),
          ),
          const Spacer(),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue)),
              child: const Text(
                "Okay!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

}