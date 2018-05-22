import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/providers/theme_provider.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/header_row.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/body_row.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/footer_row.dart';
import 'package:omppu_pad/styles.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = ThemeProvider.of(context);
    return new StreamBuilder<Map<Colorable, Color>>(
      stream: themeBloc.palette,
      builder: (context, snapshot) {
        return new Container(
          decoration: new BoxDecoration(color: snapshot.data[Colorable.background]),
          padding: new EdgeInsets.all(Spacing.gutterMini),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new HeaderRow(),
              new BodyRow(),
              new FooterRow()
            ],
          ),
        );
      }
    );
  }
}
