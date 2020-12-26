import 'package:flutter/material.dart';

class NewExpense extends StatelessWidget {
  final titeController = TextEditingController();
  final amountController = TextEditingController();
  final Function addExpense;

  void _submitForm() {
    final inputTitle = this.titeController.text;
    final inputAmount = double.parse(this.amountController.text);
    if (inputTitle.isEmpty || inputAmount < 0) {
      return;
    }
    this.addExpense(
      titeController.text,
      double.parse(amountController.text),
    );
  }

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
              onSubmitted: (val) => _submitForm(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (val) => _submitForm(),
            ),
            FlatButton(
              child: Text('Add Expense'),
              textColor: Colors.purple,
              onPressed: _submitForm,
            )
          ],
        ),
      ),
    );
  }
}
