import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_gastos/componentes/chartbar.dart';
import 'package:projeto_gastos/model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for(var i =0; i < recentTransactions.length; i++){
        bool sameDay = recentTransactions[i].data.day == weekDay.day;
        bool sameMonth = recentTransactions[i].data.month == weekDay.month;
        bool sameYear = recentTransactions[i].data.year == weekDay.year;

        if(sameDay && sameMonth && sameYear){
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue{
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(label: tr['day'], 
              value: tr['value'], 
              percentage: (tr['value'] as double) / _weekTotalValue,),
            );
          }).toList(),
        ),
      ),
    );
  }
}
