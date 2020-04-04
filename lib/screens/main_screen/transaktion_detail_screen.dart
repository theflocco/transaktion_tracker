import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:fluttermoneytracker/widgets/is_einnahme_widget.dart';

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
      body: SafeArea(child: Center(
        child: Column(
          children: <Widget>[
            Text(transaktion.name,
              style:
              TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Text(transaktion.description != null ? transaktion.description : "keine Beschreibung"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Betrag",
                style: TextStyle(fontSize: 22, color: Colors.grey),),
                IsEinnahmeWidget(transaktion: transaktion),
              ],
            ),
          ],
        ),
      )),
    );
  }
}