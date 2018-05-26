import 'package:flutter/material.dart';

import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/providers/music_player_provider.dart';
import 'package:omppu_pad/styles.dart';

class ShuffleButton extends StatelessWidget {
  final double iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MusicPlayerProvider.of(context).isShuffling, 
      initialData: false,
      builder: (context, snapshot) {
        bool isEnabled = snapshot.data;
        Color color = isEnabled ? Palette.musicGreen : Theme.of(context).iconTheme.color;

        IconButton iconButton = IconButton(
          iconSize: iconSize,
          icon: Icon(AppIcons.shuffle, color: color),
          onPressed: () {
            MusicPlayerProvider.of(context).onIsShufflingChanged.add(!isEnabled);
          }
        );

        if (isEnabled) {
          return Stack(
            children: <Widget>[
              iconButton,
              Positioned(
                top: 35.0,
                left: 20.0,
                child: Container(
                  width: 4.0,
                  height: 4.0,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                ),
              )
            ],
          );
        }
        return iconButton;
      }
    );

    
  }
}