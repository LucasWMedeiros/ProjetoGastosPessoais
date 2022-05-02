import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_gastos/model/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transaction = [
    Transaction(
        id: 't1', tittle: 'Novo Gasto', value: 350.85, data: DateTime.now()),
    Transaction(
        id: 't2', tittle: 'Conta de Luz', value: 200.00, data: DateTime.now())
  ];

  void _addTransaction(String tittle, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        tittle: tittle,
        value: value,
        data: DateTime.now());

    setState(() {
      _transaction.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transaction),
        TransactionForm(_addTransaction),
      ],
    );
  }
}
