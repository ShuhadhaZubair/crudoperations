import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Firebase_task2/updatePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ViewById.dart';
import 'addPage.dart';

class Students_homepage extends StatefulWidget {
  const Students_homepage({super.key});

  @override
  State<Students_homepage> createState() => _Students_homepageState();
}

class _Students_homepageState extends State<Students_homepage> {
  TextEditingController search = TextEditingController();
  String searchquery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Center(
            child: Icon(
          Icons.add,
          color: Colors.white,
        )),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Student_adddata(),
              ));
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "List of Interns",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Search", prefixIcon: Icon(Icons.search)),
            controller: search,
            onChanged: (value) {
              setState(() {
                searchquery=value.toLowerCase();
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("students").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.hasError)
                  return Text("Error ${snapshot.error}");
                final students = snapshot.data!.docs.where(
                        (doc){
                          String student=doc["name"].toString().toLowerCase();
                          return student.contains(searchquery);
                        }).toList();
                    // snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var doc = students[index];
                    final _data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Students_viewbyid(id: doc.id),
                            ));
                      },
                      tileColor: Colors.blue.shade50,
                      selectedTileColor: Colors.indigo,
                      title: Text(
                        _data["name"] ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        children: [
                          // Row(mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [Text("Guardian :  "),
                          //     Text(_data["guardian"]??""),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(_data["place"] ?? ""),
                            ],
                          ),
                          // Row(mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [Text("DOB :  "),
                          //     Text(_data["dob"]??""),
                          //   ],
                          // ),
                          // Row(mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text(_data["gender"]??""),
                          //   ],
                          // ),
                        ],
                      ),
                      // trailing: TextButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => Students_updatePage(),
                      //           ));
                      //     },
                      //     child: Text("Update")),
                      trailing: Column(
                        children: [
                          Expanded(
                            // child: TextButton(
                            //     onPressed: () {
                            //
                            //     },
                            //     child: Text("Update")),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Students_updatePage(
                                          id: doc.id,
                                        ),
                                      ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                  size: 18,
                                )),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("students")
                                      .doc(doc.id)
                                      .delete();
                                },
                                icon: Icon(Icons.delete,
                                    color: Colors.blue, size: 20)),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: students.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
