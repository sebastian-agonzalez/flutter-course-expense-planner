import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        amount: 69.99, id: 't1', title: 'New Coat', date: DateTime.now()),
    Transaction(
        amount: 13.99,
        id: 't2',
        title: 'Face Treatment Mask',
        date: DateTime.now()),
    Transaction(
        amount: 12.59, id: 't3', title: 'Snickers', date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    // ignore: avoid_print
    //print('passing');
    final newTx = Transaction(
        id: (Random().nextInt(99) + Random().nextInt(99)).toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
    // ignore: avoid_print
    //print(_userTransactions);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addNewTransaction: _addNewTransaction),
        TransactionList(transactions: _userTransactions)
      ],
    );
  }
}
