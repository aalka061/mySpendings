import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function addExpense;

  NewExpense(this.addExpense);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titeController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitForm() {
    if (amountController.text.isEmpty) {
      return;
    }

    final inputTitle = this.titeController.text;
    final inputAmount = double.parse(this.amountController.text);
    if (inputTitle.isEmpty || inputAmount < 0 || _selectedDate == null) {
      return;
    }
    widget.addExpense(
      inputTitle,
      inputAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePickter() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
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
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No date selected"
                          : DateFormat.yMd().format(_selectedDate)),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        "Select Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePickter,
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
      ),
    );
  }
}
