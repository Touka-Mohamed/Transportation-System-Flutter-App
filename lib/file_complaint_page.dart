import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gui/sql_db.dart';

class FileComplaintPage extends StatefulWidget
{
  const FileComplaintPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FileComplaintPageState();
}

class FileComplaintPageState extends State<FileComplaintPage>
{
  SqlDb sqlDb = SqlDb();
  var items = [
    'Dawn Trip',
    'Dusk Trip'
  ];
  DateTime selectedDate = DateTime.now();
  String selectedDirection = 'Dawn Trip';
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  bool checkDependencies()
  {
    bool passed = true;
    if(titleTextController.text.isEmpty){ passed = false; }
    if(descriptionTextController.text.isEmpty){ passed = false; }

    return passed;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File a complaint", textAlign: TextAlign.center),
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
          TextField(
            controller: titleTextController,
            decoration: const InputDecoration(hintText: "Insert title here.."),
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
              "Which trip?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),
          DropdownButton(
              alignment: AlignmentDirectional.center,
              isExpanded: true,
              value: selectedDirection,
              items: items.map((String item)
              {
                return DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue){
                setState(()=> selectedDirection = newValue!);
              }),

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
          TextField(
            controller: descriptionTextController,
            decoration: const InputDecoration(hintText: "Tell us what happened here.."),
          ),

          const Spacer(),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              onPressed: () async {
                if(!checkDependencies()){ return; }
                await sqlDb.addComplaint(selectedDate.toString(), selectedDirection, descriptionTextController.text, titleTextController.text);
                Navigator.pop(context);
              },
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