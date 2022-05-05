import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

        print(DateFormat.E().format(weekDay)[0]);
        print(totalSum);
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': 9.99,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((tr){
          return Text('${tr['day']} : ${tr['value']}');
        }).toList(),
      ),
    );
  }
}
