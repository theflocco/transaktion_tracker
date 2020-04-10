import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaction_state.dart';
import 'package:fluttermoneytracker/bloc/transaktion_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaktion_event.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:fluttermoneytracker/screens/main_screen/transaktion_detail_screen.dart';
import 'package:fluttermoneytracker/widgets/is_einnahme_widget.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class TransaktionenScreen extends StatefulWidget {
  @override
  _TransaktionenScreenState createState() => _TransaktionenScreenState();
}

class _TransaktionenScreenState extends State<TransaktionenScreen> {
  TransaktionBloc _transaktionBloc;

  List<Transaktion> transList;
  int count = 0;
  final format = new DateFormat('dd.MM.yy');

  @override
  void initState() {
    super.initState();
    _transaktionBloc = BlocProvider.of<TransaktionBloc>(context);
    _transaktionBloc.add(TransaktionEventIsLoading());
  }

  @override
  Widget build(BuildContext context) {
    Widget listElement(Transaktion transaktion) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaktion.name,
                  style: TextStyle(fontSize: 22),
                ),
                Text(format.format(transaktion.datum)),
              ],
            ),
            Column(
              children: <Widget>[IsEinnahmeWidget(transaktion: transaktion)],
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: BlocBuilder(
        bloc: _transaktionBloc,
        builder: (context, TransaktionState state) {
          return Center(
            child: state is TransaktionLoadedState
                ? Container(
                    child: new ListView.builder(
                        itemCount: state.transList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final displayedTransaktion = state.transList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransaktionDetailScreen(
                                              displayedTransaktion)));
                            },
                            child: Dismissible(
                              background: Container(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Swipe to delete",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                  color: Colors.red),
                              key: Key(displayedTransaktion.id.toString()),
                              onDismissed: (direction) {
                                setState(() {
                                  _transaktionBloc.add(TransaktionEventDelete(
                                      displayedTransaktion));
                                });
                              },
                              child: Center(
                                  child: listElement(displayedTransaktion)),
                            ),
                          );
                        }),
                  )
                : Text(
                    "Keine Transaktionen vorhanden bzw DB läd",
                    style: TextStyle(fontSize: 22),
                  ),
          );
        },
      ),
    );
  }
}
