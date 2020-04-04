
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';

class IsEinnahmeWidget extends StatelessWidget {
  Transaktion transaktion;

  IsEinnahmeWidget({@required this.transaktion});

  @override
  Widget build(BuildContext context) {
    return Text((transaktion.isEinnahme ? "" : "-") + transaktion.betrag.toString() + " €",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: transaktion.isEinnahme ? Colors.green : Colors.red
      ),
    );
  }
}
