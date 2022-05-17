// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  Widget _getIconButton(IconData icon, Function() fn){
    return Platform.isIOS
    ? GestureDetector(onTap: fn, child: Icon(icon),)
    : IconButton(onPressed: fn, icon: Icon(icon));
  }


  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    
    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandscape)
      _getIconButton(
        _showChart ? iconList : chartList
        , () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
        _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add
          , () => _opneTransactionForm(context))
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: actions,
    );
    
    final avaliableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

  final bodyPage = SafeArea(
    child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            if (_showChart || !isLandscape)
              Container(
                  height: avaliableHeight * (isLandscape ? 0.7 :  0.3),
                  child: Chart(_recentTransactions)),
            if (!_showChart || !isLandscape)
              Container(
                height: avaliableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transaction, _removeTransaction),
              ),
          ],
        ),
      ),);



    return Platform.isIOS 
    ? CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Despesas Pessoais'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      ),
      child: bodyPage,
    )
    : Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: Platform.isIOS
      ? Container() 
      :  FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opneTransactionForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
