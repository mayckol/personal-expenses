import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final Function(String) removeTransaction;

  TransactionItem({
    Key key,
    @required this.tr,
    @required this.removeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${tr.amount}'),
            ),
          ),
        ),
        title: Text(tr.title, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => removeTransaction(tr.id),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
