import 'package:fluttermoneytracker/model/transaktion.dart';

class Kontostand {
  List<Transaktion> transaktionen = [];


  double getKontostand() {
    double wert = 0;
    if (this.transaktionen.isNotEmpty) {
      this.transaktionen.forEach((trans) => {
        if (trans is Einnahme) {
          wert += trans.betrag
        } else {
          wert -= trans.betrag
        }
      });
    }
    return wert;
  }

}