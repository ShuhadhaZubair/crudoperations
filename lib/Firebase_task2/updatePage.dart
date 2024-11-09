import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Students_updatePage extends StatefulWidget {
  const Students_updatePage({super.key, required this.id});


final id;
  @override
  State<Students_updatePage> createState() => _Students_updatePageState();
}

class _Students_updatePageState extends State<Students_updatePage> {
  String edit_selectedValue = 'Male';
  DateTime? edit_selectedDate;
  String _selectedItem = 'Flutter';
  final List<String> _options = [
    'Flutter',
    'Mern',
    'Ui/Ux',
    'Digital Marketing',
  ];
  final formkey = GlobalKey<FormState>();
  var edit_name = TextEditingController();
  var edit_guardian = TextEditingController();
  var edit_place = TextEditingController();
  var edit_dob = TextEditingController();
  var edit_gender = TextEditingController();
  var edit_trade = TextEditingController();

  Future<void>studentsupdate()async{
    FirebaseFirestore.instance.collection("students").doc(widget.id).update({
      "name": edit_name.text,
      "guardian" : edit_guardian.text,
      "place" :edit_place.text,
      "dob" : DateFormat('dd/MM/yyyy')
        .format(edit_selectedDate!),
      "gender" : edit_selectedValue,
      "trade" : _selectedItem

    }
    );
    Navigator.pop(context);
  }

  Future<void> pickdate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1995),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());
    if (picked != null && picked != edit_selectedDate) {
      setState(() {
        edit_selectedDate = picked;
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
              "Update Student Data",
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
                controller: edit_name,
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
                controller: edit_guardian,
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
            //     controller: edit_dob,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller:
                TextEditingController(
                  text: edit_selectedDate == null
                      ? 'Date of Birth'
                      : DateFormat('dd/MM/yyyy')
                      .format(edit_selectedDate!), // Format the date),
                ),
                // controller: dob,
                decoration: InputDecoration(hintText: "Date of Birth",
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
                  if(value!.isEmpty) {
                    return "Invalid";
                  }
                },

              ),
            ),
            Column(
                children: [
                  ListTile(
                    title: Text('Male'),
                    leading: Radio<String>(
                      value: 'Male',
                      groupValue: edit_selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          edit_selectedValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Female'),
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: edit_selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          edit_selectedValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Other'),
                    leading: Radio<String>(
                      value: 'Other',
                      groupValue: edit_selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          edit_selectedValue = value!;
                        });
                      },
                    ),
                  ),
                ]
            ),
            DropdownButton<String>(
              isExpanded: true,
              padding: EdgeInsets.only(left: 20,right: 20),
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
                controller: edit_place,
              ),
            ),

                InkWell(onTap: () {
                  if(formkey.currentState!.validate()){
                    studentsupdate();
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
                      "Update",
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
