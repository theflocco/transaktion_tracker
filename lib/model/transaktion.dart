
import 'package:equatable/equatable.dart';

class Transaktion extends Equatable{
  int id;
  String name;
  String description;
  double betrag;
  DateTime datum;
  bool isEinnahme;


  Transaktion(
       this.name, this.betrag, this.datum, this.isEinnahme);
  Transaktion.withId(
    this.id,
       this.name, this.betrag, this.datum, this.isEinnahme);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    map['betrag'] = betrag;
    map['datum'] = datum.toIso8601String();
    map['isEinnahme'] = isEinnahme ? 1 : 0;
    return map;
  }

  Transaktion.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.betrag = map['betrag'];
    this.datum = DateTime.parse(map['datum']);
    this.isEinnahme = mapToBool(map['isEinnahme']);   
  }

  bool mapToBool(int integer) {
    if (integer == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name];
       
}
