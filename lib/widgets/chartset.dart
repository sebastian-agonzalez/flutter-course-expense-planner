import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chartset extends StatelessWidget {
  const Chartset({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, dynamic>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // ignore: avoid_print
      //print(DateFormat.E().format(weekDay));
      // ignore: avoid_print
      //print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    //print(groupedTransactionsValues);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues
              .map((data) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: data['day'] as String,
                      spendingAmount: data['amount'],
                      spendingPctOfTotal: totalSpending == 0.0
                          ? totalSpending
                          : (data['amount'] as double) / totalSpending,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }
}
