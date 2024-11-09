import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'homePage.dart';

class Student_adddata extends StatefulWidget {
  const Student_adddata({super.key});

  @override
  State<Student_adddata> createState() => _Student_adddataState();
}

class _Student_adddataState extends State<Student_adddata> {
  final formkey = GlobalKey<FormState>();
  String _selectedItem = 'Flutter';
  final List<String> _options = [
    'Flutter',
    'Mern',
    'Ui/Ux',
    'Digital Marketing',
  ];
  DateTime? _selectedDate;
  String _selectedValue = 'Male';
  var name = TextEditingController();
  var guardian = TextEditingController();
  var place = TextEditingController();
  var dob = TextEditingController();
  var gender = TextEditingController();
  var trade = TextEditingController();

  Future<void> add_studentdata() async {
    FirebaseFirestore.instance.collection("students").add({
      "name": name.text,
      "guardian": guardian.text,
      "place": place.text,
      "dob": DateFormat('dd/MM/yyyy').format(_selectedDate!),
      "gender": _selectedValue,
      "trade": _selectedItem
    });
    print("Student data updated succesfully");
    Navigator.pop(context);
  }

  Future<void> pickdate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1995),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10),
            Text(
              "Add Student Data",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white60,
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Candidate Name",
                ),
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Invalid";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white60,
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Guardian's Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Invalid";
                  }
                },
                controller: guardian,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: Colors.white60,
            //           width: 10,
            //           style: BorderStyle.solid,
            //         ),
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       hintText: "DOB dd/mm/yy",
            //     ),
            //     controller: dob,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? 'Date of Birth'
                      : DateFormat('dd/MM/yyyy')
                          .format(_selectedDate!), // Format the date),
                ),
                // controller: dob,
                decoration: InputDecoration(
                  hintText: "Date of Birth",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white60,
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onTap: () => pickdate(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Invalid";
                  }
                },
              ),
            ),
            Column(children: [
              ListTile(
                title: Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Other'),
                leading: Radio<String>(
                  value: 'Other',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ),
            ]),
            DropdownButton<String>(
              isExpanded: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              value: _selectedItem,
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue!;
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Place",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white60,
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Invalid";
                  }
                },
                controller: place,
              ),
            ),

            InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  add_studentdata();
                }
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo,
                ),
                child: Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
