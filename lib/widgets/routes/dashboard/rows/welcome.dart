import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/providers/theme_provider.dart';
import 'package:omppu_pad/styles.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = ThemeProvider.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: Spacing.gutterMini),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "OmppuPad",
                  style: Theme.of(context).textTheme.title,
                ),
                Text(
                  'Dashboard Overview',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.gutterMini),
            child: Text(
              'Night Mode',
              style: Theme.of(context).textTheme.body1.merge(
                TextStyle(fontSize: FontSize.smallText)
              ),
            ),
          ),
          CupertinoSwitch(
            value: themeBloc.isDarkThemeToggled,
            onChanged: themeBloc.toggleTheme.add
          ),
        ],
      ),
    );
  }
}
