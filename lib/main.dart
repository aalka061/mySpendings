import 'package:flutter/material.dart';
import './expense.dart';

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
  final List<Expense> expenses = [
    Expense(
      id: 'e1',
      title: 'shoes',
      amount: 70.00,
      date: DateTime.now(),
    ),
    Expense(
      id: 'e2',
      title: 'sunglasses',
      amount: 40.00,
      date: DateTime.now(),
    ),
  ];
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
            Column(
                children: expenses.map((e) {
              return Card(
                child: Text(e.title),
                elevation: 5,
              );
            }).toList()),
          ],
        ));
  }
}
