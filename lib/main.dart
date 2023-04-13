// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'package:expense_planner/widgets/chartset.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          // accentColor: Colors.amber
        ).copyWith(secondary: Colors.amber),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

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

  void _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) =>
            NewTransaction(addNewTransaction: _addNewTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
              onPressed: () => _startNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chartset(
              recentTransactions: _recentTransactions,
            ),
            TransactionList(
              transactions: _userTransactions,
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
