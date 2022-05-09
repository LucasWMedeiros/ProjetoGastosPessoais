// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final valueController = TextEditingController();

  final tittleController = TextEditingController();

  void _submitForm() {
    final title = tittleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (value) => _submitForm(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text('Nenhuma data selecionada!'),
                    FlatButton(
                        textColor: Colors.amber,
                        onPressed: () {},
                        child: Text(
                          'Selecionar Data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: _submitForm,
                    child: Text('Nova Transação'),
                    color: Colors.amber,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
