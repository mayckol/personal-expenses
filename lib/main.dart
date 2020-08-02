import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lightBlue,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'Pesca', amount: 59.90, date: DateTime.now()),
    Transaction(id: '2', title: 'Cabaré', amount: 43.90, date: DateTime.now()),
    Transaction(id: '3', title: 'Motel', amount: 229.70, date: DateTime.now()),
    Transaction(id: '4', title: 'Keyboard', amount: 99, date: DateTime.now()),
    Transaction(id: '5', title: 'Mouse', amount: 13.90, date: DateTime.now()),
    Transaction(id: '6', title: 'Vinho', amount: 15.20, date: DateTime.now()),
    Transaction(id: '8', title: 'Cerveja', amount: 7.90, date: DateTime.now()),
    Transaction(id: '9', title: 'Goiabada', amount: 7.90, date: DateTime.now()),
    Transaction(id: '10', title: 'Doce', amount: 7.90, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((tr) => tr.date.isAfter(
              DateTime.now().subtract(Duration(days: 7)),
            ))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() => _userTransactions.add(newTx));
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Widget _getIconButton({IconData icon, Function fn}) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;
    final actions = <Widget>[
      if (isLandScape)
        _getIconButton(
            icon: _showChart ? iconList : chartList,
            fn: () {
              setState(() {
                _showChart = !_showChart;
              });
            }),
      _getIconButton(
          icon: Platform.isIOS ? CupertinoIcons.add : Icons.add,
          fn: () => _startAddNewTransaction(context)),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
              /*style: TextStyle(fontFamily: 'Open Sans')*/
            ),
            actions: actions,
          );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final SafeArea _singleChildScrollView = SafeArea(
      child: SingleChildScrollView(
        child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
//            if (isLandScape)
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text('Exibir Gráfico'),
//                  Switch.adaptive(
//                    value: _showChart,
//                    activeColor: Theme.of(context).accentColor,
//                    onChanged: (value) {
//                      setState(() {
//                        _showChart = value;
//                      });
//                    },
//                  ),
//                ],
//              ),
            if (_showChart || !isLandScape)
              Container(
                height: availableHeight * (isLandScape ? 0.70 : 0.30),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandScape)
              Container(
                height: availableHeight * 0.70,
                child: TransactionList(
                  _userTransactions,
                  _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: _singleChildScrollView,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => _startAddNewTransaction(context),
                  )
                : Container(),
          )
        : CupertinoPageScaffold(
            child: _singleChildScrollView,
          );
  }
}
