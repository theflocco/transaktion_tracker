import 'package:sqlcool/sqlcool.dart';

final einnahmeTable = DbTable("einnahmen")
    ..varchar("name")
    ..varchar("betrag")
    ..varchar("description")
    ..varchar("datum");