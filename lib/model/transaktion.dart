import 'package:flutter/foundation.dart';
import 'package:fluttermoneytracker/model/dbmodels/einnahmeTable.dart';
import 'package:sqlcool/sqlcool.dart';
import '../conf.dart' as conf;

class Transaktion {
  final String name;
  String description;
  final double betrag;
  final DateTime datum;

  Transaktion(
      {@required this.name, @required this.betrag, @required this.datum});
}

class Ausgabe extends Transaktion with DbModel {
  Ausgabe(double betrag, String name, DateTime dateTime)
      : super(betrag: betrag, name: name, datum: dateTime);

  @override
  int id;
  @override
  Db get db => conf.db;
}

class Einnahme extends Transaktion with DbModel {

  Einnahme(double betrag, String name, DateTime dateTime)
      : super(betrag: betrag, name: name, datum: dateTime);
  @override
  int id;
  @override
  Db get db => conf.db;

  @override
  DbTable get table => einnahmeTable;


  @override
  Map<String, dynamic> toDb() {
    final row = <String, dynamic>{
      "name": name,
      "description": description,
      "betrag": betrag,
      "datum": datum,
    };
    return row;
  }

  // @override
  // Einnahme fromDb(Map<String, dynamic> map) {
  //   final einnahme = Einnahme(
  //     id: map["id"] as int,
  //     name: map["name"].toString(),
  //     betrag: map["betrag"] as double,
  //     description: map["description"].toString(),
  //     datum: map["datum"] as DateTime
  //   );
  // }
}
