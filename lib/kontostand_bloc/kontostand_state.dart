import 'package:equatable/equatable.dart';

class KontostandState extends Equatable {

  @override
  List<Object> get props => null;

}

class KontostandLoadedState extends KontostandState {
  final double kontostand;

  KontostandLoadedState(this.kontostand);

}

class KontostandIsLoadingState extends KontostandState {

}