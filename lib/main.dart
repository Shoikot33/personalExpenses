// ignore_for_file: prefer_const_constructors

import 'package:financeapp/widgets/newTranaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import './widgets/tranactionList.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        home: MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'Poppins',
            textTheme: ThemeData.light().textTheme.copyWith(
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
                titleTextStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transaction = [];
  final List<Transaction> _userTranaction = [
    Transaction(
        id: 'T1', title: 'New Shoes', amount: 8.03, date: DateTime.now()),
    Transaction(
        id: 'T2', title: 'New Shirt', amount: 6.55, date: DateTime.now()),
    Transaction(
        id: 'T3', title: 'New Belt', amount: 3.33, date: DateTime.now()),
    Transaction(
        id: 'T4', title: 'New Food', amount: 6.33, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTranaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTranaction.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTranaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTranaction.add(newTx);
    });
  }

  void _startAddNewTransactionv(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return NewTranaction(_addNewTranaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransactionv(context),
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.keyboard_control_rounded)),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.25,
                child: Chart(_recentTransaction)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: TransactionList(_userTranaction, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransactionv(context),
        child: Icon(Icons.dashboard_outlined),
      ),
    );
  }
}
