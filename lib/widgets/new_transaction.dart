import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
//                    onChanged: (value) => titleInput = value,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
//                    onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () => addNewTransaction(
                titleController.text,
                double.parse(amountController.text),
              ),
            )
          ],
        ),
      ),
    );
  }
}
