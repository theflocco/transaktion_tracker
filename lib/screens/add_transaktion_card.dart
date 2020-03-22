import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTransaktionCard extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
              spreadRadius: 3.0,
              offset: Offset(
                7.0,
                7.0
              )
            )
          ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.white, fontSize: 24),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Betrag eingeben'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.lightGreen,
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.remove),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
