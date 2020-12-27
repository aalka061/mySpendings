import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentExpenses;

  Chart(this.recentExpenses);

  List<Map<String, Object>> get groupedExpensesValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var total = 0.0;

      for (int i = 0; i < recentExpenses.length; i++) {
        if (recentExpenses[i].date.day == weekDay.day &&
            recentExpenses[i].date.month == weekDay.month &&
            recentExpenses[i].date.year == weekDay.year) {
          total += recentExpenses[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'TotalAmount': total,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedExpensesValues);
    return Row(
      children: [],
    );
  }
}
