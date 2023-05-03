// ignore_for_file: sized_box_for_whitespace

import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    const Text('No transactions added yet'),
                    const SizedBox(height: 20),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
                  ],
                );
              },
            )
          : ListView(
              children: transactions
                  .map(
                    (tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTransaction: deleteTransaction,
                    ),
                  )
                  .toList()
              // ListView.builder(
              //     itemCount: transactions.length,
              //     itemBuilder: (ctx, i) => TransactionItem(
              //         key: ValueKey(transactions[i].id),
              //         transaction: transactions[i],
              //         deleteTransaction: deleteTransaction),
              //   ),
              ),
    );
  }
}
