import 'dart:ffi';

import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final valueController = TextEditingController();
  final tittleController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                controller: tittleController,
                decoration: InputDecoration(
                  labelText: 'Titulo',
                ),
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(labelText: 'Valor R\$'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {
                      final title = tittleController.text;
                      final value = double.tryParse(valueController.text) ?? 0.0;
                      onSubmit(title, value);
                    },
                    child: Text('Nova Transação'),
                    textColor: Colors.purple,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
