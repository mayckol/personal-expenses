import 'package:flutter/material.dart';
import 'transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraint) => Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                    height: constraint.maxHeight * 0.60,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return TransactionItem(
                  removeTransaction: onRemove,
                  tr: tr,
                );
              },
            ),
    );
  }
}
