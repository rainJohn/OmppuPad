import 'package:flutter/material.dart';
import 'package:omppu_pad/providers/music_player_provider.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var musicPlayerBloc = MusicPlayerProvider.of(context);
    return StreamBuilder(
        stream: musicPlayerBloc.duration,
        initialData: 1.0,
        builder: (context, durationSnapshot) {
          return StreamBuilder(
            stream: musicPlayerBloc.progress,
            initialData: 0.0,
            builder: (progressContext, progressSnapshot) {
              return Slider(
                activeColor: Theme.of(context).textTheme.body2.color,
                max: durationSnapshot.data,
                value: progressSnapshot.data,
                divisions: durationSnapshot.data.toInt(),
                onChanged: (value) => musicPlayerBloc.onProgressChanged.add(value)
              );
            }
          );
        }
    );
  }
}