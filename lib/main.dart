// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_gastos/model/transaction.dart';

main() => runApp(ExpansesApp());

class ExpansesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transaction = [
    Transaction(id: 't1',tittle: 'Novo Gasto', value: 350.85, data: DateTime.now()),
     Transaction(id: 't2', tittle: 'Conta de Luz', value: 200.00, data: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              child: Card(
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            Column(
              children: _transaction.map((tr) {
                return Card(
                  child: Text(tr.tittle),
                );
              }).toList(),
            )
          ],
        ));
  }
}
