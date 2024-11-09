
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'viewPage.dart';


class Screen1 extends StatefulWidget {
  const Screen1({super.key});


  @override
  State<Screen1> createState() => _Screen1State();
}


class _Screen1State extends State<Screen1> {
  final formkey = GlobalKey<FormState>();
  var name= TextEditingController();
  var price= TextEditingController();
  var description = TextEditingController();

  Future<void>add_details()async {
    FirebaseFirestore.instance.collection("product").add({
      "name": name.text,
      "price" : price.text,
      "description" :description.text

    });
    print("Product updated succesfully");
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Product Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 30,
                        ))),
                controller: name,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Invalid";
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 30,
                        ))),
                controller: price,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Invalid";
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Weight",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 30,
                        ))),
                controller: description,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Invalid";
                  }
                },
              ),
            ),


            SizedBox(height: 50),
            InkWell(onTap: () {
              if(formkey.currentState!.validate()){
                add_details();
              }


            },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo,
                ),
                child: Center(child: Text("Submit",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
