import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoneytracker/model/dbmodels/database_helper.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:fluttermoneytracker/blocs/transaction_bloc/transaktion_bloc.dart';
import 'package:fluttermoneytracker/blocs/transaction_bloc/transaktion_event.dart';

class AddTransaktionCard extends StatefulWidget {
  @override
  _AddTransaktionCardState createState() => _AddTransaktionCardState();
}

class _AddTransaktionCardState extends State<AddTransaktionCard> {
  final TextEditingController betragController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController descriptionController = new TextEditingController();
  DatabaseHelper helper = new DatabaseHelper();
  TransaktionBloc _transaktionBloc;
  bool showInfo = false;

  @override
  void initState() {
    super.initState();
    _transaktionBloc = BlocProvider.of<TransaktionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(18.0, 18, 8, 18),
            child: Column(
              children: <Widget>[
                Text(
                  "Transaktion hinzufügen",
                  style: TextStyle(fontSize: 22),
                ),
                showInfo ? Text("Bitte Betrag und Name eingeben",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18
                ),) : Text(""),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: descriptionController,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Beschreibung eingeben'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.lightGreen,
                      child: Icon(Icons.add),
                      onPressed: () {
                        addTransaction(true);
                      }
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        addTransaction(false);
                      },
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

  addTransaction(bool isEinnahme) {
    if (betragController.value.text.isNotEmpty && nameController.value.text.isNotEmpty) {
      Transaktion einnahme = new Transaktion(nameController.text, double.parse(betragController.text), new DateTime.now(), isEinnahme);
      einnahme.description = descriptionController.text;
      TransaktionEventAdd eventAdd = new TransaktionEventAdd(einnahme);
      _transaktionBloc.add(eventAdd);
      Navigator.of(context).pop();
    } else {
      setState(() {
        this.showInfo = true;
      });
    }
  }
}
