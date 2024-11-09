import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Vegetables extends StatefulWidget {
  const Vegetables({super.key});

  @override
  State<Vegetables> createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Vegetables").where("category",isEqualTo: "Vegetables").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasError) return Text("Error.${snapshot.error}");
        final Vegetables = snapshot.data?.docs ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            var doc = Vegetables[index];
            final _data = doc.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(_data["name"] ?? ""),
              subtitle: Text(_data["price"] ?? ""),
            );
          },
          itemCount: Vegetables.length,
        );
      },
    ));
  }
}
