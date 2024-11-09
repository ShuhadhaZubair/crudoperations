import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});

  @override
  State<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Vegetables").where("category",isEqualTo: "Grocery").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if(snapshot.hasError) return Text("Error.${snapshot.error}");
          final Vegetables = snapshot.data?.docs??[];
          return  ListView.builder(itemBuilder: (context, index) {
            var doc= Vegetables[index];
            final _data=doc.data() as Map<String,dynamic>;
            return
              ListTile(
                title: Text(_data["name"]??""),
                subtitle: Text(_data["price"]??""),
              );
          },
            itemCount: Vegetables.length,



          );
        },
      )

    );
  }
}
