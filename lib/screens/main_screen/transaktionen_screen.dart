import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaction_state.dart';
import 'package:fluttermoneytracker/bloc/transaktion_bloc.dart';
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
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Transaktion> transList;
  int count = 0;
  final format = new DateFormat('dd.MM.yy');

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Transaktion>> transListFuture =
          databaseHelper.getTransaktionListSorted();
      transListFuture.then((transList) {
        setState(() {
          this.transList = transList;
          this.count = transList.length;
        });
      });
    });
  }

  void updateListViewAsync(TransaktionBloc transaktionBloc) {
    Future<TransaktionState> transListFuture = transaktionBloc.fetch();
    transListFuture.then((value) {
      setState(() {
        transList = value.transList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /* if (transList == null) {
      transList = List<Transaktion>();
      updateListView();
    } */

    TransaktionBloc transaktionBloc = BlocProvider.of<TransaktionBloc>(context);
    if (transList == null) {
      updateListViewAsync(transaktionBloc);
    }
    Widget ListElement(Transaktion transaktion) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(transaktion.name,
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
                Text(format.format(transaktion.datum)),

              ],
            ),
            Column(
              children: <Widget>[
                IsEinnahmeWidget(transaktion: transaktion)
              ],
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: BlocListener(
        bloc: transaktionBloc,
        listener: (context, state) {
          this.updateListViewAsync(transaktionBloc);
        },
        child: Center(
          child: this.transList != null
              ? Container(
                  child: new ListView.builder(
                      itemCount: this.transList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TransaktionDetailScreen(this.transList[index])));
                          },
                          child: Dismissible(
                            background: Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Swipe to delete",
                                style: TextStyle(color: Colors.black,
                                fontSize: 18),),
                              ),
                                color: Colors.red),
                            key: Key(this.transList[index].id.toString()),
                            onDismissed: (direction) {
                              setState(() {
                                this.databaseHelper.deleteTransaktion(transList[index]);
                                this.transList.removeAt(index);
                              });
                            },
                            child: Center(
                                child:  ListElement(this.transList[index])),
                          ),
                        );
                      }),
                )
              : Text("Keine Transaktionen vorhanden",
          style: TextStyle(
            fontSize: 22
          ),),
        ),
      ),
    );
  }


}
