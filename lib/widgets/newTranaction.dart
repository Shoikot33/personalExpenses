import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranaction extends StatefulWidget {
  final Function addTx;

  NewTranaction(this.addTx);

  @override
  State<NewTranaction> createState() => _NewTranactionState();
}

class _NewTranactionState extends State<NewTranaction> {
  String titleInput = '';
  DateTime? _selectedDate;
  double amountInput = 0.00;

  void _submitOnPressButton() {
    if (titleInput.isEmpty || amountInput <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(titleInput, amountInput, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => {titleInput = value},
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  amountInput = double.parse(value);
                },
                keyboardType: TextInputType.number,
                onSubmitted: (e) => _submitOnPressButton(),
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Text(
                    _selectedDate == null
                        ? "No Date Chosen!"
                        : "Picked Date: " +
                            DateFormat.yMd().format(_selectedDate!),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitOnPressButton,
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
