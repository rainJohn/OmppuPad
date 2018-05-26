import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omppu_pad/blocs/time_bloc.dart';

import 'package:omppu_pad/providers/theme_provider.dart';
import 'package:omppu_pad/providers/time_provider.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/welcome.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/location_context_cards.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/utility_cards.dart';
import 'package:omppu_pad/styles.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<Colorable, Color>>(
      stream: ThemeProvider.of(context).palette,
      initialData: Palette.dark,
      builder: (context, snapshot) {
        return TimeProvider(
          timeBloc: TimeBloc(),
          child: Container(
            decoration: BoxDecoration(color: snapshot.data[Colorable.background]),
            padding: EdgeInsets.all(Spacing.gutterMini),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Welcome(),
                LocationContextCards(),
                UtilityCards()
              ],
            ),
          ),
        );
      }
    );
  }
}
