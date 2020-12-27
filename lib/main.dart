import 'package:flutter/material.dart';
import 'package:my_spendings/widgets/expense_list.dart';
import 'package:my_spendings/widgets/new_expense.dart';
import 'models/expense.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: '',
                    fontSize: 20,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> expenses = [];

  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  final List<Expense> _userExpenses = [
    // Expense(
    //   id: 'e1',
    //   title: 'shoes',
    //   amount: 70.00,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: 'e2',
    //   title: 'sunglasses',
    //   amount: 40.00,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewExpense(String title, double amount) {
    final newExp = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _userExpenses.add(newExp);
    });
  }

  void _showNewExpensemodal(BuildContext ctx) {
    // ctx is pased from the build method
    // bCtx is the context if we are building
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewExpense(_addNewExpense),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter app"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showNewExpensemodal(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            ExpenseList(_userExpenses),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showNewExpensemodal(context);
        },
      ),
    );
  }
}
