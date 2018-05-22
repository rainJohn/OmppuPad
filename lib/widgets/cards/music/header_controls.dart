import 'package:flutter/material.dart';

class HeaderControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new IconButton(
          icon: new Icon(Icons.search),
          onPressed: () => print('TODO handle search')),
        new IconButton(
          icon: new Icon(Icons.more_vert),
          onPressed: () => print('TODO handle options'))
      ],
    );
  }
}