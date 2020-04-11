import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/kontostand_bloc/kontostand_bloc.dart';
import 'package:fluttermoneytracker/kontostand_bloc/kontostand_event.dart';
import 'package:fluttermoneytracker/kontostand_bloc/kontostand_state.dart';

import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/kontostand.dart';
import 'package:fluttermoneytracker/transaction_bloc/transaction_state.dart';


class KontostandScreen extends StatefulWidget {

  @override
  _KontostandScreenState createState() => _KontostandScreenState();
}

class _KontostandScreenState extends State<KontostandScreen> {
  Kontostand kontostand = new Kontostand();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  double kontostandValue = 0;

  KontostandBloc _kontostandBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kontostandBloc = BlocProvider.of<KontostandBloc>(context);
    _kontostandBloc.add(KontostandEventGetKontostand());
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: _kontostandBloc,
      builder: (context, KontostandState state) {
        return state is KontostandLoadedState ? SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Kontostand: ',
                        style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.kontostand.toString() + " €",
                        style: Theme
                            .of(context)
                            .textTheme
                            .display1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ) : Text("Loading");
      },
    );


  }
}
