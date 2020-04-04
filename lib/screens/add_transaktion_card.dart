import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaktion_bloc.dart';
import 'package:fluttermoneytracker/bloc/transaktion_event.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';

class AddTransaktionCard extends StatefulWidget {
  @override
  _AddTransaktionCardState createState() => _AddTransaktionCardState();
}

class _AddTransaktionCardState extends State<AddTransaktionCard> {
  final TextEditingController betragController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  DatabaseHelper helper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    TransaktionBloc transaktionBloc = BlocProvider.of<TransaktionBloc>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20.0,
                  spreadRadius: 3.0,
                  offset: Offset(7.0, 7.0))
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Transaktion hinzufügen",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: betragController,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Betrag eingeben'),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Name eingeben'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.lightGreen,
                      child: Icon(Icons.add),
                      onPressed: () => addTransaction(true, transaktionBloc),
                    ),
                    FloatingActionButton(
                      onPressed: () => addTransaction(false, transaktionBloc),
                      backgroundColor: Colors.redAccent,
                      child: Icon(Icons.remove),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTransaction(bool isEinnahme, TransaktionBloc bloc) {
    if (betragController.value.toString().isNotEmpty) {
      Transaktion einnahme = new Transaktion(nameController.text, double.parse(betragController.text), new DateTime.now(), isEinnahme);
      //this.helper.insertTransaktion(einnahme);
      TransaktionEventAdd eventAdd = new TransaktionEventAdd(einnahme);
      bloc.add(eventAdd);
      Navigator.of(context).pop();
    }
  }
}
