import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_spendings/widgets/expense_list.dart';
import 'package:my_spendings/widgets/new_expense.dart';
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

class _MyHomePageState extends State<MyHomePage> {
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.70,
      child: ExpenseList(
        _userExpenses,
        _deleteExpense,
      ),
    );

    final chartAreaLandscape = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.70,
      child: Chart(this._recentExpenses),
    );

    final chartAreaPortrait = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
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
                    Switch(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showNewExpensemodal(context);
        },
      ),
    );
  }
}
