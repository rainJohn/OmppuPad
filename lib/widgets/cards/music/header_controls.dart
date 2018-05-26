import 'package:flutter/material.dart';

class HeaderControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => print('TODO handle search')),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => print('TODO handle options'))
      ],
    );
  }
}