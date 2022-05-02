// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_gastos/model/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  // ignore: prefer_const_constructors_in_immutables
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
              children: transactions.map((tr) {
                return Card(
                  child: Row(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'R\$ ${tr.value.toStringAsFixed(2)}',
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.tittle,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          DateFormat('dd MM y').format(tr.data),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ]),
                );
              }).toList(),
            );;
  }
}