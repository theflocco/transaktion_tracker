import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoneytracker/model/transaktion.dart';
import 'package:simple_animations/simple_animations.dart';

class KontostandBarChart extends StatefulWidget {
  @override
  _KontostandBarChartState createState() => _KontostandBarChartState();
}

class _KontostandBarChartState extends State<KontostandBarChart> {
  static Transaktion transaktion1 = new Transaktion(
      "Mockmockmock1", 200, DateTime.now(), true);
  static Transaktion transaktion2 = new Transaktion(
      "Mockmockmock2", 150, DateTime.now(), true);
  static Transaktion transaktion3 = new Transaktion(
      "Mockmockmockmock3", 15, DateTime.now(), true);
  List<Transaktion> mockList = [transaktion1, transaktion2, transaktion3];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 5.0,
            blurRadius: 10,
            offset: Offset(
              5.0,
              5.0
            )
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(8)
        )
      ),
      margin: EdgeInsets.all(10.0),
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mockList.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleBar(transaktion: mockList[index]);
          }
      ),
    );
  }
}

class SingleBar extends StatelessWidget {
  const SingleBar({
    Key key,
    @required this.transaktion,
  }) : super(key: key);

  final Transaktion transaktion;

  @override
  Widget build(BuildContext context) {
    int _containerWidgetHeight = 200;
    int _stretchFactor = 150;
    int _baseDurationMs = 1;
    double _maxElementHeight = transaktion.betrag / _containerWidgetHeight * _stretchFactor;
    //double _animatedHeight = 1;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ControlledAnimation(
          duration: Duration(milliseconds: (_containerWidgetHeight * _baseDurationMs).round()),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, _animatedHeight) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: Theme.of(context).accentColor,
                  width: 20,
                  height: (1 - _animatedHeight) * _maxElementHeight,
                ),
                Container(
                  width: 20,
                  height: _animatedHeight * _maxElementHeight,
                  color: Colors.green,
                ),
                Text(transaktion.name.toString(),
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w500),)
              ],
            );
          },
        )
    );
  }
}
