import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';

class TransaktionDetailScreen extends StatefulWidget {
  final Transaktion transaktion;

  const TransaktionDetailScreen(this.transaktion);
  @override
  _TransaktionDetailScreenState createState() => _TransaktionDetailScreenState(transaktion);
}

class _TransaktionDetailScreenState extends State<TransaktionDetailScreen> {
  final Transaktion transaktion;

  _TransaktionDetailScreenState(this.transaktion);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: <Widget>[
          Text(transaktion.name),
          Text(transaktion.description != null ? transaktion.description : "keine Beschreibung"),
          Text(transaktion.betrag.toString()),
          Text(transaktion.isEinnahme.toString())
        ],
      )),
    );
  }
}