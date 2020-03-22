import 'package:flutter/material.dart';
import 'package:fluttermoneytracker/model/kontostand.dart';
import 'package:fluttermoneytracker/screens/add_transaktion_card.dart';

import 'model/transaktion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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

  void _addEinnahme() {
    setState(() {
      Einnahme einnahme = new Einnahme(1, "neue Einnahme", new DateTime.now());
      kontostand.transaktionen.add(einnahme);
    });
  }

  void _addAusgbe() {
    setState(() {
      Ausgabe ausgabe = new Ausgabe(1, "neue Ausgabe", new DateTime.now());
      kontostand.transaktionen.add(ausgabe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(""),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Kontostand: ',
                ),
                Text(
                  kontostand.getKontostand().toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
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
          this.kontostand.transaktionen.length > 0
              ? Expanded(
                child:new ListView.builder(
                    itemCount: this.kontostand.transaktionen.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(child: new Text(this.kontostand.transaktionen[index].name));
                    }),
              )
              : Text("Keine Einträge vorhanden"),
              AddTransaktionCard(),
        ],
      ),
    );
  }
}
