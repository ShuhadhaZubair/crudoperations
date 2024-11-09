import 'package:flutter/material.dart';

import 'Fruits.dart';
import 'Groceries.dart';
import 'Vegetables.dart';
import 'addProduct.dart';

class Viewproduct extends StatefulWidget {
  const Viewproduct({super.key});

  @override
  State<Viewproduct> createState() => _ViewproductState();
}

class _ViewproductState extends State<Viewproduct> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(child: Center(child: Icon(Icons.add,color: Colors.white,)),
          backgroundColor: Colors.indigo,onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Addproduct(),));
        },),
          appBar: AppBar(
        title: Text("Category",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.indigoAccent,
          ),
          tabs: [
            Tab(
              child: Text(
                'VEGETABLES',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'FRUITS',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'GROCERY',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
              body: TabBarView(
          children: [
            Vegetables(),
      Fruits(),
      Groceries()
      // Call the second class
      ],
    ),

      ),
    );
  }
}
