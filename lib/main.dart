import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter app"),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              child: Card(
                child: Center(child: Text("Chart")),
                elevation: 6,
                shadowColor: Colors.blue,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Card(
                child: Text('List of expenses'),
                elevation: 6,
                shadowColor: Colors.blue,
              ),
            ),
          ],
        ));
  }
}
