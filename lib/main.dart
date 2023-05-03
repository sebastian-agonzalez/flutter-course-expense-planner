// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import './models/transaction.dart';
import 'package:expense_planner/widgets/chartset.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'dart:io';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

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
            labelMedium: TextStyle(color: Colors.red),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    print(appState);
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    // ignore: avoid_print
    //print('passing');
    final newTx = Transaction(
        id: (Random().nextInt(99) + Random().nextInt(99)).toString(),
        title: title,
        amount: amount,
        date: selectedDate);
    print(newTx);
    setState(() {
      _userTransactions.add(newTx);
    });
    // ignore: avoid_print
    //print(_userTransactions);
  }

  void _deleteTransaction(String id) {
    _userTransactions.removeWhere((element) => element.id == id);
    setState(() {});
  }

  void _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builderContext) => SingleChildScrollView(
        child: Container(
          child: NewTransaction(addNewTransaction: _addNewTransaction),
        ),
      ),
    );
  }

  bool _showChart = false;

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscapeMode = mediaQuery.orientation == Orientation.landscape;
    final Widget appBar = _buildAppBar();

    List<Widget> buildLandscapeMode() => [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Show Chart'),
              Switch(
                value: _showChart,
                onChanged: (v) => setState(() {
                  _showChart = v;
                }),
              ),
            ],
          ),
          _showChart
              ? getChartsetContainer(
                  context,
                  mediaQuery,
                  appBar,
                  0.7,
                )
              : getTxListContainer(context, mediaQuery, appBar)
        ];

    List<Widget> buildPortraitMode() => [
          getChartsetContainer(context, mediaQuery, appBar, 0.3),
          getTxListContainer(context, mediaQuery, appBar),
        ];

    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscapeMode)
              ...buildLandscapeMode()
            else
              ...buildPortraitMode()
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Container getChartsetContainer(
    BuildContext context,
    MediaQueryData mediaQuery,
    appBar,
    double heightSizePercentage,
  ) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          heightSizePercentage,
      child: Chartset(
        recentTransactions: _recentTransactions,
      ),
    );
  }

  Container getTxListContainer(
    BuildContext context,
    MediaQueryData mediaQuery,
    appBar,
  ) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
  }
}
