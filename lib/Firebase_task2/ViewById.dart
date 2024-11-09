import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Students_viewbyid extends StatefulWidget {
  const Students_viewbyid({super.key, this.id});
  final id;
  @override
  State<Students_viewbyid> createState() => _Students_viewbyidState();
}

class _Students_viewbyidState extends State<Students_viewbyid> {

  DocumentSnapshot? students;
  Future<void> _getbyid() async {
    students = await FirebaseFirestore.instance
        .collection("students")
        .doc(widget.id)
        .get();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blue.shade50,
        body: FutureBuilder(
      future: _getbyid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasError) return Text("Error ${snapshot.error}");

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Student's Details",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  students!["name"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(students!["guardian"]),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(students! ["dob"]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(students!["gender"]),
              ],
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(students! ["trade"]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(students!["place"]),
              ],
            ),
          ],
        );
      },
    ));
  }
}
