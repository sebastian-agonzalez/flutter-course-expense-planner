// ignore_for_file: sized_box_for_whitespace

import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: transactions.isEmpty
          ? Column(
              children: [
                const Text('No transactions added yet'),
                const SizedBox(height: 20),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, i) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          FittedBox(child: Text('\$${transactions[i].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[i].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[i].date),
                  ),
                ),
              ),
            ),
    );
  }

  Row newMethod(BuildContext context, int i) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: Theme.of(context).colorScheme.primary),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                '\$${transactions[i].amount.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              transactions[i].title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              DateFormat().add_yMMMd().add_Hm().format(transactions[i].date),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
