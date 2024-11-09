import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Task_1/viewBy_id.dart';
import 'package:flutter/material.dart';

import 'editPage.dart';
import 'homePage.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController search= TextEditingController();
  String searchquery ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Screen1(),
                ));
          },
        ),
        body: Column(
          children: [
            Text(
              "View Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
            TextFormField(
              decoration: InputDecoration(prefixIcon: Icon(Icons.search),hintText: "Search"),
              controller: search,
              onChanged: (value) {
                setState(() {
                  searchquery=value.toLowerCase();
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("product")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  else if (snapshot.hasError)
                    return Text("Error ${snapshot.error}");
                  final product = snapshot.data!.docs.where(
                          (doc){
                            String products = doc["name"].toString().toLowerCase();
                            return products.contains(searchquery);
                          }).toList();
                      // snapshot.data?.docs ?? [];   code without search query,final product= ......
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var doc = product[index];
                      final _data = doc.data() as Map<String, dynamic>;
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewbyId(id: doc.id),
                              ));
                        },
                        tileColor: Colors.blue.shade50,
                        selectedTileColor: Colors.indigo,
                        title: Text(_data["name"] ?? ""),
                        subtitle: Text("Description"),
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
                                          builder: (context) => Editpage(
                                            id: doc.id,
                                          ),
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.update,
                                    color: Colors.blue,
                                    size: 20,
                                  )),
                            ),
                            // TextButton(onPressed: () {
                            //
                            // }, child: Text("Delete")),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("product")
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
                    itemCount: product.length,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
