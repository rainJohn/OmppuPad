import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/providers/theme_provider.dart';
import 'package:omppu_pad/styles.dart';

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = ThemeProvider.of(context);
    return new Container(
      padding: EdgeInsets.only(bottom: Spacing.gutterMini),
      child: Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Home Dashboard",
                  style: Theme.of(context).textTheme.title,
                ),
                new Text(
                  'Overview',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            )
          ),
          new Padding(
            padding: EdgeInsets.only(right: Spacing.gutterMini),
            child: new Text('Night Mode',
              style: Theme.of(context).textTheme.body1.merge(
                new TextStyle(fontSize: FontSize.smallText)
              ),
            ),
          ),
          new CupertinoSwitch(
            value: themeBloc.isDarkThemeToggled,
            onChanged: (value) => themeBloc.toggleTheme.add(value)
          ),
        ],
      ),
    );
  }
}
