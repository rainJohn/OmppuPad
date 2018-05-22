import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:omppu_pad/api/hue.dart';
import 'package:omppu_pad/styles.dart';

class LightsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightsCardState();
}

class _LightsCardState extends State<LightsCard> {
  // use external bloc and listen to streams
  bool enabled;
  bool bedroomEnabled;
  bool livingRoomEnabled;

  void onToggleSwitch(bool value, int hueGroup) {
    HueAPI.toggleLightsByGroup(value, hueGroup);
    this.setState(() {
      if (hueGroup == HueAPI.HUE_GROUP_ALL) {
        enabled = !enabled;
        bedroomEnabled = enabled;
        livingRoomEnabled = enabled;
      } else if (hueGroup == HueAPI.HUE_GROUP_BEDROOM) {
        bedroomEnabled = !bedroomEnabled;
        enabled = bedroomEnabled;
      } else { // living room
        livingRoomEnabled = !livingRoomEnabled;
        enabled = livingRoomEnabled;
      }
    });
  }

  Dialog buildLightsDialog(BuildContext context) {
    return new Dialog(
      child: new Container(
        constraints: new BoxConstraints(maxWidth: 300.0, maxHeight: 285.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Spacing.gutterMicro),
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(Spacing.gutterMicro),
                child: new Text(
                  'Toggle Room Lights',
                  style: Theme.of(context).textTheme.body2
                )
              ),
              new Divider(),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.gutterMini),
                child: new Column (
                  children: <Widget>[
                    new ToggleSwitchRow(
                      title: 'Master Switch',
                      value: enabled,
                      onChanged: (value) => onToggleSwitch(value, HueAPI.HUE_GROUP_ALL),
                    ),
                    new ToggleSwitchRow(
                      title: 'Bedroom',
                      value: false,
                      onChanged: (value) => onToggleSwitch(value, HueAPI.HUE_GROUP_BEDROOM),
                    ),
                    new ToggleSwitchRow(
                      title: 'Living Room',
                      value: false,
                      onChanged: (value) => onToggleSwitch(value, HueAPI.HUE_GROUP_LIVING_ROOM),
                    )
                  ]
                )
              ),
              new Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(
                    textColor: Colors.deepOrangeAccent,
                    child: new Text('Close'),
                    onPressed: () => Navigator.pop(context)
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: EdgeInsets.only(
          bottom: Spacing.gutterMini,
          left: Spacing.gutterMini,
          top: Spacing.gutterMini
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('Lights'),
            new FutureBuilder<bool>(
              future: HueAPI.checkAnyLightsOn(),
              builder: (context, snapshot) {
                enabled = false;
                if (snapshot.hasData) {
                  enabled = snapshot.data;
                  bedroomEnabled = snapshot.data;
                  livingRoomEnabled = snapshot.data; //TODO change async builder to check for each room
                }
                return new Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CupertinoSwitch(
                      value: enabled,
                      onChanged: (value) => onToggleSwitch(value, HueAPI.HUE_GROUP_ALL),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.more_vert),
                      onPressed: () => showDialog(
                        context: context,
                        builder: buildLightsDialog
                      ),
                    ),
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleSwitchRow extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChanged;

  ToggleSwitchRow({this.title, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.gutterMicro),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(title, style: Theme.of(context).textTheme.body1),
          new CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}