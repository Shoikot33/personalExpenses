// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

// ignore: use_key_in_widget_constructors
class TransactionList extends StatelessWidget {
  final List<Transaction> userTranaction;
  final Function deleteTx;

  TransactionList(this.userTranaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child:
                    FittedBox(child: Text('\$${userTranaction[index].amount}')),
              ),
            ),
            title: Text(
              userTranaction[index].title,
            ),
            subtitle:
                Text(DateFormat.yMMMd().format(userTranaction[index].date)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteTx(userTranaction[index].id),
              color: Theme.of(context).errorColor,
            ),
          ),
        );
      },
      itemCount: userTranaction.length,
    );
  }
}
