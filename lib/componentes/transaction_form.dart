// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _valueController = TextEditingController();

  final _tittleController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _tittleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double bottomPading = MediaQuery.of(context).viewInsets.bottom;
    print(MediaQuery.of(context).viewInsets.bottom);
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 +  MediaQuery.of(context).viewInsets.bottom
              ),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextField(
                  controller: _tittleController,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                  ),
                ),
                TextField(
                  controller: _valueController,
                  decoration: InputDecoration(labelText: 'Valor R\$'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (value) => _submitForm(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MMM/y').format(_selectedDate!)}'),
                      ),
                      FlatButton(
                          textColor: Colors.amber,
                          onPressed: _showDatePicker,
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
                      child: Text(
                        'Nova Transação',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      color: Colors.amber,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
