import 'package:flutter/material.dart';
import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/styles.dart';

class ShuffleButton extends StatelessWidget {
  final bool isEnabled;
  final Function onPressed;

  ShuffleButton({this.isEnabled, this.onPressed});

  Widget getIconButton(Color color, double iconSize) {
    return new IconButton(
        iconSize: iconSize,
        icon: new Icon(AppIcons.shuffle, color: color),
        onPressed: onPressed);
  }

  Widget getActiveIconButton(Color color, double iconSize) {
    return new Stack(
      children: <Widget>[
        getIconButton(color, iconSize),
        new Positioned(
          top: 35.0,
          left: 20.0,
          child: new Container(
            width: 4.0,
            height: 4.0,
            decoration: new BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var color = isEnabled ? Palette.musicGreen : Theme.of(context).iconTheme.color;
    var iconSize = 20.0;
    return isEnabled
        ? getActiveIconButton(color, iconSize)
        : getIconButton(color, iconSize);
  }
}