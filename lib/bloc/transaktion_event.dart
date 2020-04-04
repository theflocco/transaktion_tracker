import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';

class TransaktionEvent {
  Transaktion transaktion;
  TransaktionEvent(Transaktion transaktion) {
    this.transaktion = transaktion;
  }

}

class TransaktionEventAdd extends TransaktionEvent {

  TransaktionEventAdd(
  Transaktion transaktion) : super(transaktion);

}

class TransaktionEventDelete extends TransaktionEvent {
  TransaktionEventDelete(
      Transaktion transaktion) : super(transaktion);
}

class TransaktionEventUpdate extends TransaktionEvent {
  TransaktionEventUpdate(
      Transaktion transaktion) : super(transaktion);
}