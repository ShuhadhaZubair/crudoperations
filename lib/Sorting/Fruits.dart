import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fruits extends StatefulWidget {
  const Fruits({super.key});

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Vegetables").where("category",isEqualTo: "Fruit").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator());
        else if(snapshot.hasError) return Text("Error ${snapshot.error}");
        final Vegetables = snapshot.data?.docs??[];
        return  ListView.builder(itemBuilder: (context, index) {
          var doc= Vegetables[index];
          final _data = doc.data() as Map<String,dynamic>;
          return  ListTile(
            title: Text(_data["name"]??""),
            subtitle: Text(_data["price"]?? ""),
          );
        },
          itemCount: Vegetables.length,



        );
      },
    )

    );
  }
}
