// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:projeto_gastos/componentes/transaction_user.dart';

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
  

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                child: Card(
                  child: Text('Gráfico'),
                  elevation: 5,
                ),
              ),
              TransactionUser()
            ],
          ),
        ));
  }
}
