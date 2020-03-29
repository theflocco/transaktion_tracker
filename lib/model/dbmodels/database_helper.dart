import 'dart:io';

import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  
	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

  
	String transaktiontable = 'transaktion_table';
	String colId = 'id';
	String colName = 'name';
	String colDescription = 'description';
	String colDatum = 'datum';
  String colBetrag = 'betrag';
  String colIsEinnahme = 'isEinnahme';


	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

  	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $transaktiontable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colDescription TEXT, $colDatum TEXT, $colBetrag REAL, $colIsEinnahme INTEGER)');
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos.db';
    //await deleteDatabase(path);
    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  	// Fetch Operation: Get all todo objects from database
	Future<List<Map<String, dynamic>>> getTransaktionMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
		var result = await db.query(transaktiontable, orderBy: '$colName ASC');
		return result;
	}

	// Insert Operation: Insert a todo object to database
	Future<int> insertTransaktion(Transaktion transaktion) async {
		Database db = await this.database;
		var result = await db.insert(transaktiontable, transaktion.toMap());
		return result;
	}

  	// Get number of todo objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $transaktiontable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	Future<double> getKontoStand() async {
		double kontostand = 0;
		var transaktionList = await getTransaktionList();
		transaktionList.forEach((trans) =>
		{
			if (trans.isEinnahme) {
				kontostand += trans.betrag
			} else
				{
					kontostand -= trans.betrag
				}
		});

		return kontostand;
}

	Future<List<Transaktion>> getTransaktionList() async {

		var todoMapList = await getTransaktionMapList(); // Get 'Map List' from database
		int count = todoMapList.length;         // Count the number of map entries in db table

		List<Transaktion> todoList = List<Transaktion>();
		// For loop to create a 'todo List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			todoList.add(Transaktion.fromMapObject(todoMapList[i]));
		}

		return todoList;
	}



}
