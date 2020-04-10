import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';

class TransaktionEvent extends Equatable {

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class TransaktionEventIsLoading extends TransaktionEvent {

}

class TransaktionEventAdd extends TransaktionEvent {
  final Transaktion transaktion;

  TransaktionEventAdd(this.transaktion);

}

class TransaktionEventDelete extends TransaktionEvent {
  final Transaktion transaktion;

  TransaktionEventDelete(this.transaktion);
}

class TransaktionEventGetKontostand extends TransaktionEvent {

}

class TransaktionEventUpdate extends TransaktionEvent {
  final Transaktion transaktion;

  TransaktionEventUpdate({@required this.transaktion});
}