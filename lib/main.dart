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
              color: Colors.black
            )
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )

    ));
        
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
   
  ];

  List<Transaction> get _recentTransactions{
    return _transaction.where((tr){
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
  
    _removeTransaction(String id){
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _opneTransactionForm(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Chart(_recentTransactions),
            TransactionList(_transaction, _removeTransaction),
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
