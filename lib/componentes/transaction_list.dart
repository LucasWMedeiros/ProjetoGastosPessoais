// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_gastos/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemoved;

  // ignore: prefer_const_constructors_in_immutables
  TransactionList(this.transactions, this.onRemoved);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
     ? LayoutBuilder(
       builder: (context, constraints){
       return Column(
        children: [
          Text('Nenhuma Transação Cadastrada',
          style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
         );
       }
     ) : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tr = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(child: Text('R\$${tr.value}',
                 style: TextStyle(color: Colors.white),)),
              ),
            ),
            title: Text(
              tr.tittle,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat('dd MMM y').format(tr.data)
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => onRemoved(tr.id),
            ),
          ),
        );
      },
    );
  }
}
