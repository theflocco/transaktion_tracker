import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/kontostand.dart';
import 'package:fluttermoneytracker/repository/init_db.dart';
import 'package:fluttermoneytracker/screens/add_transaktion_card.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlcool/sqlcool.dart';

import 'model/transaktion.dart';

void main() {
  runApp(MyApp());

  initDb(db: new Db());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TransactionApp',
      theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Kontostand kontostand = new Kontostand();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Transaktion> transList;
  int count = 0;

  void _addEinnahme() {
    setState(() {
      Transaktion einnahme = new Transaktion("neue Einnahme", 1, new DateTime.now(), true);
      kontostand.transaktionen.add(einnahme);
      databaseHelper.insertTransaktion(einnahme);
      updateListView();
    });
  }

  void _addAusgbe() {
    setState(() {
      Transaktion ausgabe = new Transaktion("neue Ausgabe",1, new DateTime.now(), false);
      kontostand.transaktionen.add(ausgabe);
      databaseHelper.insertTransaktion(ausgabe);

      updateListView();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (transList == null) {
      transList = List<Transaktion>();
      updateListView();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Transaktionen"),
          ),
        ],
      ),
      body: SafeArea(
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
                      kontostand.getKontostand().toString() + " €",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _addEinnahme,
                    tooltip: 'Hinzufügen',
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: _addAusgbe,
                    tooltip: 'Abziehen',
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
            this.count > 0
                ? Expanded(
                    child: new ListView.builder(
                        itemCount: this.count,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: new Text(
                                  this.transList[index].name));
                        }),
                  )
                : Text("Keine Einträge vorhanden"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => onButtonPressed(context),
      ),
    );
  }

  onButtonPressed(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
           return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: AddTransaktionCard(this.updateListView),
          ));
        });
  }

  
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Transaktion>> transListFuture = databaseHelper.getTransaktionList();
      transListFuture.then((transList) {
        setState(() {
          this.transList = transList;
          this.count = transList.length;
        });
      });
    });
  }
}
