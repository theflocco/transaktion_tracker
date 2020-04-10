import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaction_state.dart';
import 'package:fluttermoneytracker/bloc/transaktion_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaktion_event.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/kontostand.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:sqflite/sqflite.dart';

class KontostandScreen extends StatefulWidget {

  @override
  _KontostandScreenState createState() => _KontostandScreenState();
}

class _KontostandScreenState extends State<KontostandScreen> {
  Kontostand kontostand = new Kontostand();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  double kontostandValue = 0;

  TransaktionBloc _transaktionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transaktionBloc = BlocProvider.of<TransaktionBloc>(context);
    _transaktionBloc.add(TransaktionEventGetKontostand());
  }

  void fetchKontoStand() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<double> kontostandFuture = databaseHelper.getKontoStand();
      kontostandFuture.then((kontostandDouble) => {
        if (kontostandDouble != this.kontostandValue) {
          setState(() {
            //TODO: Bloc pattern einbauen um Widgets neu zu zeichnen :)
            this.kontostandValue = kontostandDouble;
          })
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //fetchKontoStand();

    return BlocBuilder(
      bloc: _transaktionBloc,
      builder: (context, TransaktionState state) {
        return state is TransaktionKontostandLoaded ? SafeArea(
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
        ) : Text("Loadign");
      },
    );


  }
}
