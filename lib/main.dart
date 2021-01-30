import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/expense_list.dart';
import './widgets/new_expense.dart';
import 'models/expense.dart';
import './widgets/chart.dart';

void main() {
  // disallow user from using landscape mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
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
                button: TextStyle(color: Colors.black),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Expense> expenses = [];

  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  final List<Expense> _userExpenses = [
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

  bool _isShowChart = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Expense> get _recentExpenses {
    return _userExpenses.where((ex) {
      return ex.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewExpense(String title, double amount, DateTime chosenDate) {
    final newExp = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      _userExpenses.add(newExp);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      _userExpenses.removeWhere((element) {
        return element.id == id;
      });
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Flutter app"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showNewExpensemodal(context);
          },
        ),
      ],
    );

    final expList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.70,
      child: ExpenseList(
        _userExpenses,
        _deleteExpense,
      ),
    );

    final chartAreaLandscape = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.70,
      child: Chart(this._recentExpenses),
    );

    final chartAreaPortrait = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.30,
      child: Chart(this._recentExpenses),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show chart"),
                    Switch.adaptive(
                      value: _isShowChart,
                      onChanged: (val) {
                        setState(() {
                          _isShowChart = val;
                          print(_isShowChart);
                        });
                      },
                    )
                  ],
                ),
              ),
            if (isLandscape) _isShowChart ? chartAreaLandscape : expList,
            if (!isLandscape) chartAreaPortrait,
            if (!isLandscape) expList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _showNewExpensemodal(context);
              },
            ),
    );
  }
}
