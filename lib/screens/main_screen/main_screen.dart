import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/kontostand.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:sqflite/sqflite.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Kontostand kontostand = new Kontostand();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  double kontostandValue = 0;

  void fetchKontoStand() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<double> kontostandFuture = databaseHelper.getKontoStand();
      kontostandFuture.then((kontostandDouble) => {
        if (kontostandDouble != this.kontostandValue) {
          setState(() {
            //TODO: Bloc pattern einbauen um Widgets neu zu zeichnen :)
            this.kontostandValue = kontostandDouble;
          })
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchKontoStand();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Kontostand: ',
                    style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(

                    kontostandValue.toString() + " €",
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
