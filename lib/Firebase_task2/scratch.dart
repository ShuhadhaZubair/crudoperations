import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("Student's Details"),
      Expanded(
        child: ListView.builder(itemBuilder: (context, index) {
        
          return ListTile(
            tileColor: Colors.blue.shade50,
            selectedTileColor: Colors.indigo,
            title: Text("name"),
            subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text("guardian"),
                    Text("guardian"),
                    Text("guardian"),
                    Text("guardian"),
                  ],
                ),
              ],
            ),
            trailing: TextButton(
                onPressed: () {
        
                },
                child: Text("Update")),
          );
        },
          itemCount: 3,
        ),
      )
      ],),
    );
  }
}
