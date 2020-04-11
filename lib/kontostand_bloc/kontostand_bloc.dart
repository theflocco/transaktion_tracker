import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/kontostand_bloc/kontostand_event.dart';
import 'package:fluttermoneytracker/kontostand_bloc/kontostand_state.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';

class KontostandBloc extends Bloc<KontostandEvent, KontostandState> {

  DatabaseHelper _helper = new DatabaseHelper();



  @override
  // TODO: implement initialState
  KontostandState get initialState => KontostandIsLoadingState();

  @override
  Stream<KontostandState> mapEventToState(KontostandEvent event) async* {
  if (event is KontostandEventGetKontostand) {
    yield KontostandIsLoadingState();
    yield* _reloadKontostand();
    }
  }

  Stream<KontostandState> _reloadKontostand() async* {
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
    yield KontostandLoadedState(kontostand);
  }

}