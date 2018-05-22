import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/styles.dart';

class ClockCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  Timer timer;
  DateTime now = DateTime.now();
  final double cardSize = 300.0;

  _ClockCardState() {
    timer = new Timer.periodic(
      new Duration(seconds: 1),
      (Timer timer) => this.setState(() => now = DateTime.now())
    );
  }

  static final DateFormat hourFormat = new DateFormat('HH:mm');
  static final DateFormat secondFormat = new DateFormat('ss');
  static final DateFormat dateFormat = new DateFormat('EEEE, dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: cardSize,
      width: cardSize,
      child: new Card(
        child: new Stack(
          alignment: Alignment(0.0, 0.0),
          children: <Widget>[
            new PositionedDirectional(
              start: 65.0,
              child: new Text(
                hourFormat.format(now),
                style: Theme.of(context).textTheme.body2.merge(
                  new TextStyle(fontSize: 50.0),
                ),
              ),
            ),
            new PositionedDirectional(
              top: 127.0,
              start: 205.0,
              child: new Text(
                secondFormat.format(now),
                style: Theme.of(context).textTheme.body2.merge(
                  new TextStyle(
                    fontSize: FontSize.smallText,
                    color: Colors.deepOrangeAccent
                  ),
                ),
              ),
            ),
            new Positioned(
              bottom: 55.0,
              child: new Text(
                dateFormat.format(now),
                style: Theme.of(context).textTheme.body1.merge(
                  new TextStyle(fontSize: FontSize.subheadText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
