import 'package:flutter/material.dart';
import 'new_expense.dart';
import 'expense_list.dart';
import '../models/expense.dart';

class UserExpenses extends StatefulWidget {
  @override
  _UserExpensesState createState() => _UserExpensesState();
}

class _UserExpensesState extends State<UserExpenses> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewExpense(),
        ExpenseList(this._userExpenses),
      ],
    );
  }
}
