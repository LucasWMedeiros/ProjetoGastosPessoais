// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_gastos/componentes/chart.dart';
import 'package:projeto_gastos/componentes/transaction_form.dart';
import 'package:projeto_gastos/componentes/transaction_list.dart';
import 'package:projeto_gastos/model/transaction.dart';

main() => runApp(ExpansesApp());

class ExpansesApp extends StatelessWidget {
  final ThemeData tema = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        theme: tema.copyWith(
            colorScheme: tema.colorScheme.copyWith(
              primary: Colors.amber,
              secondary: Colors.pink,
            ),
            textTheme: tema.textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transaction.where((tr) {
      return tr.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String tittle, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        tittle: tittle,
        value: value,
        data: date);

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
  }

  _opneTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _opneTransactionForm(context),
        )
      ],
    );

    final avaliableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            if(isLandscape)
            Row(
              children: [
                Text('Exibir Gráfico'),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
            if (_showChart || !isLandscape)
              Container(
                  height: avaliableHeight * (isLandscape ? 0.7 :  0.3),
                  child: Chart(_recentTransactions)),
            if (!_showChart || !isLandscape)
              Container(
                height: avaliableHeight * 0.7,
                child: TransactionList(_transaction, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opneTransactionForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
