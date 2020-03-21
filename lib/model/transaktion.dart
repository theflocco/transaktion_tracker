import 'package:flutter/foundation.dart';


class Transaktion {
  String name;
  String description;
  double betrag;
  DateTime datum;

  Transaktion({
    @required this.name,
    @required this.betrag,
    @required this.datum
  });

}

class Ausgabe extends Transaktion {
  Ausgabe(double betrag, String name, DateTime dateTime):
    super(betrag: betrag, name: name, datum: dateTime);
}

class Einnahme extends Transaktion {
  Einnahme(double betrag, String name, DateTime dateTime):
    super(betrag: betrag, name: name, datum: dateTime);
}