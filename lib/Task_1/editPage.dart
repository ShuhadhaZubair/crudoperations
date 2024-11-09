import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Task_1/viewPage.dart';
import 'package:flutter/material.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key, required  this.id});
  final id;

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  final formkey = GlobalKey<FormState>();
  var edit_name= TextEditingController();
  var edit_price = TextEditingController();
  var edit_weight = TextEditingController();
  Future<void>update()async {
    FirebaseFirestore.instance.collection("product").doc(widget.id).update(
        {  "name": edit_name.text,
          "price" : edit_price.text,
          "description" :edit_weight.text});
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
                controller: edit_name,
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
                controller: edit_price,
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
                controller: edit_weight,
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
                update();
              }


            },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo,
                ),
                child: Center(child: Text("Edit",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
