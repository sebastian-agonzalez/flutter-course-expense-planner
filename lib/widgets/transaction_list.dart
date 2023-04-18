// ignore_for_file: sized_box_for_whitespace

import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 366,
      child: transactions.isEmpty
          ? Column(
              children: [
                const Text('No transactions added yet'),
                const SizedBox(height: 20),
                Container(
                    height: 380,
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
                  trailing: IconButton(
                      onPressed: (() => deleteTransaction(transactions[i].id)),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      )),
                ),
              ),
            ),
    );
  }
}
