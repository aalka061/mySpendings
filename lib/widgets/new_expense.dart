import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function addExpense;

  NewExpense(this.addExpense);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titeController = TextEditingController();

  final amountController = TextEditingController();

  void _submitForm() {
    final inputTitle = this.titeController.text;
    final inputAmount = double.parse(this.amountController.text);
    if (inputTitle.isEmpty || inputAmount < 0) {
      return;
    }
    widget.addExpense(
      inputTitle,
      inputAmount,
    );
    Navigator.of(context).pop();
  }

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
            Container(
              height: 70,
              child: Row(
                children: [
                  Text("No date selected"),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Select Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add Expense'),
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitForm,
            )
          ],
        ),
      ),
    );
  }
}
