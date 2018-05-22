import 'package:flutter/material.dart';

import 'package:omppu_pad/styles.dart';

class TrackDescription extends StatelessWidget {
  final String title;
  final String artist;

  TrackDescription({this.title, this.artist});

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4.0, horizontal: Spacing.gutterMini),
          child: new Text(
            title, //TODO animate overflow to scroll back and forth
            style: Theme.of(context).textTheme.body2,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
        new Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.gutterMini),
          child: new Text(
            artist,
            style: Theme.of(context).textTheme.body1.merge(
              new TextStyle(fontSize: 13.0)
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}