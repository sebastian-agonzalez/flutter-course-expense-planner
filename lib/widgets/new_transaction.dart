import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addNewTransaction});

  final Function addNewTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  //void submitData([BuildContext? context]) {
    void submitData() {
    if (titleController.text.isNotEmpty &&
        double.parse(amountController.text) > 0) {
      widget.addNewTransaction(
          titleController.text, double.parse(amountController.text));
      //if (context != null) {
        Navigator.of(context).pop();
        //dissmissKeyboard(context);
      //}
      //dismiss keyboard just for button funcitonality
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
              onSubmitted: (_) => submitData(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),
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
