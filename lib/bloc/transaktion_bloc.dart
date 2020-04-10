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
  TransaktionState get initialState => getInitState();

  TransaktionState getInitState() {
    return TransaktionIsLoadingState();
  }

  Future<List<Transaktion>> fetch() async {
    List<Transaktion> list =  await _helper.getTransaktionListSorted();
    return list;
  }

  @override
  Stream<TransaktionState> mapEventToState(TransaktionEvent event) async* {

    if (event is TransaktionEventAdd) {
      yield TransaktionIsLoadingState();
      await _helper.insertTransaktion(event.transaktion);
    } else if ( event is TransaktionEventDelete) {
      yield TransaktionIsLoadingState();
      await _helper.deleteTransaktion(event.transaktion);
    } else if (event is TransaktionEventUpdate) {
      //TODO: Implement me
    } else if (event is TransaktionEventIsLoading) {
      yield TransaktionIsLoadingState();
    } else if (event is TransaktionEventGetKontostand) {
      yield* _reloadKontostand();
      return;
    }
    yield* _reloadTransaktions();
  }

  Stream<TransaktionState> _reloadTransaktions() async* {
    final transaktions = await _helper.getTransaktionListSorted();
    yield TransaktionLoadedState(transaktions);
  }

  Stream<TransaktionState> _reloadKontostand() async* {
    final transaktionList = await _helper.getTransaktionListSorted();
    double kontostand = 0;
    transaktionList.forEach((trans) =>
    {
      if (trans.isEinnahme) {
        kontostand += trans.betrag
      } else
        {
          kontostand -= trans.betrag
        }
    });
    yield TransaktionKontostandLoaded(kontostand);
  }


}