import 'package:flutter/material.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_text_field.dart';

import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double, DateTime) addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AdaptativeTextField(
              controller: _titleController,
              inputDecoration: InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            AdaptativeTextField(
              controller: _amountController,
              inputDecoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChanged: (newDate) => setState(
                () => _selectedDate = newDate,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AdaptativeButton(
                  label: 'Add Transaction',
                  onPressed: submitData,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
