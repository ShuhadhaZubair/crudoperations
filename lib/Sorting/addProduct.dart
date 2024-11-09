import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final formkey = GlobalKey<FormState>();
  String _selectedItem = 'Fruit';
  final List<String> _options = [
    'Fruit',
    'Vegetables',
    'Grocery',

  ];
  var name = TextEditingController();
  var price = TextEditingController();
  var category = TextEditingController();

  Future<void>add_details() async{
    FirebaseFirestore.instance.collection("Vegetables").add({
      "name" : name.text,
      "price" : price.text,
      "category" :  _selectedItem
    });
    print("Product added succesfully");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formkey,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("Add Product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: TextFormField(decoration: InputDecoration(hintText: "product"),
            controller: name,
            ),
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
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(decoration: InputDecoration(hintText: "price"),controller: price,),
            ),
            InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
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
