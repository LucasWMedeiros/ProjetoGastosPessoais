// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptativeButton(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            child: Text(
              label,
              style:
                  TextStyle(color: Theme.of(context).textTheme.button?.color),
            ),
            onPressed: onPressed,
          );
  }
}

class AdaptativeTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keybordType;
  final Function(String)? onSubmitted;

  const AdaptativeTextField({
      this.label,
      this.controller,
      this.keybordType = TextInputType.text,
      this.onSubmitted,
    });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? Padding(
      padding: EdgeInsets.only(
        bottom: 10
      ),
      child: CupertinoTextField(
        controller: controller,
        keyboardType: keybordType,
        onSubmitted: onSubmitted,
        placeholder: label,
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12
        ),
      ),
    )
    :  TextField(
      controller: controller,
      keyboardType: keybordType,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label
      ),
    );
  }
}

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker(
    this.selectedDate,
    this.onDateChanged
  );

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        minimumDate: DateTime(2019),
        maximumDate: DateTime.now(),
        onDateTimeChanged: onDateChanged,
      ),
    )
    : SizedBox(
      height: 70,
      child: Row(
        children: [
          Text(
            selectedDate == null 
            ? 'Nenhuma data selecionada!'
            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate!)}',
          ),
          TextButton(
            onPressed: () => _showDatePicker(context), 
            child: Text('Selecionar Data', style: TextStyle(
              fontWeight: FontWeight.bold
            ),),)
        ],
      ),
    );
  }
}