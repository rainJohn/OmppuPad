import 'package:flutter/material.dart';
import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/models/music_player.dart';
import 'package:omppu_pad/styles.dart';

class RepeatButton extends StatelessWidget {
  final Repeat repeatMode;
  final Function onPressed;
  final double iconSize = 22.0;

  RepeatButton({this.repeatMode, this.onPressed});

  Widget getActiveIconButton(Color color) {
    return new Stack(
      children: getButtonWithActiveOverlays(color),
    );
  }

  List<Widget> getButtonWithActiveOverlays(Color color) {
    var list = new List<Widget>();
    list.add(getIconButton(color));
    if (repeatMode != Repeat.off) {
      list.add(getRepeatDotOverlay());
    }
    if (repeatMode == Repeat.one) {
      list.add(getRepeatOneOverlay());
    }
    return list;
  }

  Widget getRepeatDotOverlay() {
    return new Positioned(
      top: 35.0,
      right: 22.5,
      child: new Container(
        width: 4.0,
        height: 4.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle, color: Palette.musicGreen),
      ),
    );
  }

  Widget getRepeatOneOverlay() {
    if (repeatMode != Repeat.one) return null;
    return new Positioned(
        top: 20.0,
        right: 18.0,
        child: new Container(
            height: 8.0,
            width: 8.0,
            child: new Text(
              '1',
              style: new TextStyle(
                  color: Palette.musicGreen,
                  fontSize: 6.0,
                  fontWeight: FontWeight.bold),
            )));
  }

  Widget getIconButton(Color color) {
    return new IconButton(
        iconSize: iconSize,
        icon: new Icon(AppIcons.repeat, color: color),
        onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    var color = repeatMode != Repeat.off
        ? Palette.musicGreen
        : Theme.of(context).iconTheme.color;

    return repeatMode == Repeat.off
        ? getIconButton(color)
        : getActiveIconButton(color);
  }
}