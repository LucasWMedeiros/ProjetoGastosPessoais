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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transaction),
        TransactionForm()
      ],
    );
  }
}
