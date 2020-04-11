import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:fluttermoneytracker/screens/main_screen/transaktion_detail_screen.dart';
import 'package:fluttermoneytracker/blocs/transaction_bloc/transaction_state.dart';
import 'package:fluttermoneytracker/blocs/transaction_bloc/transaktion_bloc.dart';
import 'package:fluttermoneytracker/blocs/transaction_bloc/transaktion_event.dart';
import 'package:fluttermoneytracker/widgets/is_einnahme_widget.dart';
import 'package:intl/intl.dart';

class TransaktionListScreen extends StatefulWidget {
  @override
  _TransaktionListScreenState createState() => _TransaktionListScreenState();
}

class _TransaktionListScreenState extends State<TransaktionListScreen> {
  TransaktionBloc _transaktionBloc;

  List<Transaktion> transList;
  int count = 0;
  final format = new DateFormat('dd.MM.yy');
  static final NO_TRANSACTIONS_STRING = "Keine Transaktionen vorhanden bzw DB läd";
  static final SWIPE_TO_DELETE = "Swipe to delete";

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

    Widget createTransaktionList() {
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
                                  SWIPE_TO_DELETE,
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
                NO_TRANSACTIONS_STRING,
                style: TextStyle(fontSize: 22),
              ),
            );
          },
        ),
      );
    }
    
    return createTransaktionList();
  }
  


}
