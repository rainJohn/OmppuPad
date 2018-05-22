import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:battery/battery.dart';

import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/styles.dart';

class BatteryCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BatteryCardState();
}

class _BatteryCardState extends State<BatteryCard> {
  static final battery = new Battery();
  IconData icon;
  int percentage;

  Timer timer;

  _BatteryCardState() {
    if (icon == null) icon = AppIcons.batteryFull;
    if (percentage == null) percentage = 100;

    try {
      battery.onBatteryStateChanged.listen((BatteryState state) {
        if (state == BatteryState.full) {
          if (timer != null) timer.cancel();
          return this.setState(() {
            icon = AppIcons.batteryFull;
            percentage = 100;
          });
        }

        timer =
            new Timer.periodic(new Duration(minutes: 1), updateBatteryStatus);

        if (state == BatteryState.charging) {
          return this.setState(() => icon = AppIcons.batteryCharging);
        }
        if (state == BatteryState.discharging) {
          return updateBatteryStatus(timer);
        }
      });
    } catch (e) {
      percentage = 110;
      icon = AppIcons.batteryFull;
    }
  }

  void updateBatteryStatus(Timer timer) async {
    try {
      int batteryLevel = await battery.batteryLevel;
      IconData currentIcon = getIconByBatteryLevel(batteryLevel);
      if (currentIcon != icon || batteryLevel != percentage) {
        this.setState(() {
          icon = currentIcon;
          percentage = batteryLevel;
        });
      }
    } catch (e) {
      print('Battery status fetching failed.');
    }
  }

  IconData getIconByBatteryLevel(int batteryLevel) {
    if (batteryLevel >= 90) return AppIcons.batteryFull;
    if (batteryLevel >= 60) return AppIcons.battery75;
    if (batteryLevel > 5) return AppIcons.battery25;
    return AppIcons.batteryEmpty;
  }

  Color getIconColor() {
    if (icon == AppIcons.batteryCharging) return Colors.greenAccent[400];
    if (icon == AppIcons.batteryEmpty) return Colors.red[400];
    if (percentage <= 15) return Colors.yellow;
    return Colors.green[700];
  }

  // TODO use async builder instead
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: EdgeInsets.all(Spacing.gutterMini),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Battery',
              style: Theme.of(context).textTheme.body1,
            ),
            new Row(children: <Widget>[
              new Text(
                "$percentage %",
                style: Theme.of(context).textTheme.body1,
              ),
              new Padding(
                  padding: EdgeInsets.only(left: Spacing.gutterMicro),
                  child: new Icon(
                    // TODO someday replace with Android icons if .ttf is updated
                    icon,
                    color: getIconColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
