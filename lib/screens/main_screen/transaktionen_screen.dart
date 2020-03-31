import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class TransaktionenScreen extends StatefulWidget {
  @override
  _TransaktionenScreenState createState() => _TransaktionenScreenState();
}

class _TransaktionenScreenState extends State<TransaktionenScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Transaktion> transList;
  int count = 0;
  final format = new DateFormat('dd.MM.yy');
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Transaktion>> transListFuture =
          databaseHelper.getTransaktionListSorted();
      transListFuture.then((transList) {
        setState(() {
          this.transList = transList;
          this.count = transList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (transList == null) {
      transList = List<Transaktion>();
      updateListView();
    }

    ListElement(Transaktion transaktion) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(format.format(transaktion.datum)),
                Text(transaktion.name,
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: <Widget>[
                Text((transaktion.isEinnahme ? "" : "-") + transaktion.betrag.toString() + " €",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: transaktion.isEinnahme ? Colors.green : Colors.red
                  ),),
              ],
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: this.count > 0
            ? Container(
                child: new ListView.builder(
                    itemCount: this.count,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                          child:  ListElement(this.transList[index]));
                    }),
              )
            : Text("Keine Einträge vorhanden"),
      ),
    );
  }


}
