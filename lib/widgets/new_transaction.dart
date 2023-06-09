// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({super.key, required this.addNewTransaction}) {
    //
    print('Constructor NewTransaction Widget');
  }

  final Function addNewTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState() {
    print('Constructor _NewTransactionState Widget');
  }

  @override
  void initState() {
    print(' _NewTransactionState initState ');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print(' _NewTransactionState didUpdateWidget ');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print(' _NewTransactionState dispose ');
    super.dispose();
  }

  //void submitData([BuildContext? context]) {
  void submitData() {
    if (_titleController.text.isNotEmpty &&
        double.parse(_amountController.text) > 0 &&
        _selectedDate != null) {
      widget.addNewTransaction(_titleController.text,
          double.parse(_amountController.text), _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1991),
            lastDate: DateTime.now())
        .then((value) => {
              if (value != null) {_selectedDate = value, setState(() {})}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                onSubmitted: (_) => submitData(),
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
              onSubmitted: (_) => submitData(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary),
                    child: const Text('Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              // style: ElevatedButton.styleFrom(
              //     backgroundColor: p(context).colorScheme.primary),
              child: const Text('Add Transaction'),
              //onPressed: () => submitData(context),
              onPressed: () => submitData(),
            )
          ],
        ),
      ),
    );
  }
}
