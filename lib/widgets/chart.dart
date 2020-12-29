import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import './chart_bar.dart';

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
        'totalAmount': total,
      };
    }).reversed.toList();
  }

  double get totalExpenses {
    return groupedExpensesValues.fold(0.0, (sum, item) {
      return sum + (item['totalAmount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedExpensesValues);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedExpensesValues.map(
            (d) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  d['day'],
                  d['totalAmount'],
                  totalExpenses == 0.0
                      ? 0.0
                      : (d['totalAmount'] as double) / totalExpenses,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
