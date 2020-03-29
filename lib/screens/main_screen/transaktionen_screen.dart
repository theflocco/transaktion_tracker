import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:sqflite/sqflite.dart';

class TransaktionenScreen extends StatefulWidget {
  @override
  _TransaktionenScreenState createState() => _TransaktionenScreenState();
}

class _TransaktionenScreenState extends State<TransaktionenScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Transaktion> transList;
  int count = 0;

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Transaktion>> transListFuture =
          databaseHelper.getTransaktionList();
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
        child: Column(
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(transaktion.name,
                ),
                Text(transaktion.betrag.toString() + " €",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: transaktion.isEinnahme ? Colors.green : Colors.red
                  ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(transaktion.datum.toLocal().toString()),
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
