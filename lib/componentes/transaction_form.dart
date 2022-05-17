// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_gastos/componentes/adaptatives_widgets.dart';

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
                AdaptativeTextField(
                  label: 'Titulo',
                  controller: _tittleController,
                  onSubmitted: (_) => _submitForm,
                ),
                AdaptativeTextField(
                  label: 'Valor (R\$)',
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm,
                  keybordType: TextInputType.numberWithOptions(decimal: true),
                ),
                AdaptativeDatePicker(
                  _selectedDate,
                  (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton(
                      'Nova Transação',
                      _submitForm)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
