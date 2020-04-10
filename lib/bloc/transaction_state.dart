import 'package:equatable/equatable.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';

class TransaktionState extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => null;

}


class TransaktionIsLoadingState extends TransaktionState {
}

class TransaktionLoadedState extends TransaktionState {
  final List<Transaktion> transList;
  TransaktionLoadedState(this.transList);
}

class TransaktionKontostandLoaded extends TransaktionState {
  final double kontostand;
  TransaktionKontostandLoaded(this.kontostand);
}