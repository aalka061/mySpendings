import 'package:flutter/material.dart';

class NewExpense extends StatelessWidget {
  final titeController = TextEditingController();
  final amountController = TextEditingController();
  final Function addExpense;

  NewExpense(this.addExpense);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titeController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add Expense'),
              textColor: Colors.purple,
              onPressed: () {
                this.addExpense(
                  titeController.text,
                  double.parse(amountController.text),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
