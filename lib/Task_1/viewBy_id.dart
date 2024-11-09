import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewbyId extends StatefulWidget {
  const ViewbyId({super.key, required this.id});
final id;
  @override
  State<ViewbyId> createState() => _ViewbyIdState();
}

class _ViewbyIdState extends State<ViewbyId> {
  DocumentSnapshot? product;
  Future<void>getbyid()async{
product= await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blue.shade50,
      body: FutureBuilder(
        future: getbyid(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
              else if(snapshot.hasError) return Text("Error ${snapshot.error}");

              return  Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(product!["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  ],
                ),
                SizedBox(height: 50,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 500,width:200,
                        child: Text(product!["description"])),
                  ],
                )
              ],);
        },

      ),
    );
  }
}
