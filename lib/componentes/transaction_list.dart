// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_gastos/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  // ignore: prefer_const_constructors_in_immutables
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          Text('Nenhuma Transação Cadastrada',
          style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            child: Row(children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)),
                padding: EdgeInsets.all(10),
                child: Text(
                  'R\$ ${tr.value.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.tittle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    DateFormat('dd MM y').format(tr.data),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
