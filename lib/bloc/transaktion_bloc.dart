import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttermoneytracker/bloc/transaction_state.dart';
import 'package:fluttermoneytracker/bloc/transaktion_event.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:sqflite/sqflite.dart';

class TransaktionBloc extends Bloc<TransaktionEvent, TransaktionState> {
  DatabaseHelper _helper = new DatabaseHelper();

  @override
  // TODO: implement initialState
  TransaktionState get initialState => getInitState();

  Future<TransaktionState> fetch() async {
    List<Transaktion> list =  await _helper.getTransaktionListSorted();
    return new TransaktionState(list);
  }


  @override
  Stream<TransaktionState> mapEventToState(TransaktionEvent event) async* {

    if (event is TransaktionEventAdd) {
      _helper.insertTransaktion(event.transaktion);
    } else if ( event is TransaktionEventDelete) {
      _helper.deleteTransaktion(event.transaktion);
    } else if (event is TransaktionEventUpdate) {
      //TODO: Implement me
    }
    yield* fetch().asStream();
  }

  List<Transaktion> get refreshList => updateListView();

  TransaktionState getInitState() {
    Future<Database> dbFuture = _helper.initializeDatabase();
    dbFuture.then((db) {
    Future<TransaktionState> listFuture = fetch();
        listFuture.then((value) {return value;});
    });
  }


  List<Transaktion> updateListView() {
    final Future<Database> dbFuture = _helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Transaktion>> transListFuture =
      _helper.getTransaktionListSorted();
      transListFuture.then((transList) {
        return transList;
      });
    });
  }



}