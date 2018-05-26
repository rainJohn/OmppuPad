import 'package:flutter/material.dart';
import 'package:omppu_pad/providers/time_provider.dart';

import 'package:omppu_pad/styles.dart';

class ClockCard extends StatelessWidget {
  final double cardSize = 300.0;

  @override
  Widget build(BuildContext context) {
    var timeBloc = TimeProvider.of(context);
    return Container(
      height: cardSize,
      width: cardSize,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150.0,
                  child: StreamBuilder(
                    stream: timeBloc.hourAndMinutes,
                    initialData: '',
                    builder: (_, snapshot) =>
                      Text(
                        snapshot.data,
                        style: Theme.of(context).textTheme.body2.merge(
                          TextStyle(fontSize: 50.0),
                        ),
                      ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: 20.0,
                  child: StreamBuilder(
                    stream: timeBloc.seconds,
                    initialData: '',
                    builder: (_, snapshot) => 
                      Text(
                        snapshot.data,
                        style: Theme.of(context).textTheme.body2.merge(
                          TextStyle(
                              fontSize: FontSize.smallText,
                              color: Colors.deepOrangeAccent
                          ),
                        ),
                      ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Spacing.gutterMini),
              child: StreamBuilder(
                stream: timeBloc.date,
                initialData: '',
                builder: (_, snapshot) =>
                  Text(
                    snapshot.data,
                    style: Theme.of(context).textTheme.body1.merge(
                      TextStyle(
                        fontSize: FontSize.subheadText
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
