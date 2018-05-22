import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:omppu_pad/api/spotify.dart';
import 'package:omppu_pad/utils/keychain.dart';
import 'package:omppu_pad/blocs/theme_bloc.dart';
import 'package:omppu_pad/providers/theme_provider.dart';
import 'package:omppu_pad/widgets/routes/dashboard/dashboard.dart';

void main() async {
  // load keychain before app load
  // also refresh spotify token here
  Future.wait([
    new Keychain().loadKeys(),
    SpotifyAPI.refreshAuthToken()
  ]).then((_) {
    // Disable system bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Lock orientation to landscape only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    runApp(new OmppuPad());
  });
}

class OmppuPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = ThemeBloc();
    return new ThemeProvider(
      themeBloc: themeBloc,
      child: new StreamBuilder<ThemeData>(
        stream: themeBloc.theme,
        builder: (context, snapshot) {
          return new MaterialApp(
            title: 'Omppu Pad',
            theme: snapshot.data, 
            home: new Dashboard(),
          );
        }
      ),
    );
  }
}
