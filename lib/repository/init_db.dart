import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:sqlcool/sqlcool.dart';
import '../conf.dart' as conf;

Future<void> initDb({
  @required Db db,
  String path = "einnahmen.sqlite",
}) async {
  DbTable einnahmen = DbTable("einnahmen")
    ..varchar("name")
    ..varchar("betrag")
    ..varchar("description")
    ..varchar("datum");
  List<DbTable> schema = [einnahmen];

  String dbPath = "db.sqlite";
  try {
    await db.init(path: dbPath, schema: schema);
  } catch (e) {
    rethrow;
  }
  print("Database initialized with schema:");
  db.schema.describe();
}

Future<int> insertTransaktion(Einnahme trans) {
  trans.sqlInsert(verbose: true);
}
