import 'package:flutter/material.dart';
import 'package:omppu_pad/providers/music_player_provider.dart';

import 'package:omppu_pad/styles.dart';

class TrackDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var musicPlayerBloc = MusicPlayerProvider.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: Spacing.gutterMini
          ),
          child: StreamBuilder(
            stream: musicPlayerBloc.track,
            initialData: '',
            builder: (context, snapshot) => 
              Text(
                snapshot.data,
                style: Theme.of(context).textTheme.body2,
                overflow: TextOverflow.fade,
                softWrap: false,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.gutterMini),
          child: StreamBuilder(
            stream: musicPlayerBloc.artist,
            initialData: '',
            builder: (context, snapshot) =>
              Text(
                snapshot.data,
                style: Theme.of(context).textTheme.body1.merge(
                  TextStyle(fontSize: 13.0)
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
          ),
        ),
      ],
    );
  }
}