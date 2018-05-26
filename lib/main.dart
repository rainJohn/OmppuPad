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
    Keychain().loadKeys(),
    SpotifyAPI.refreshAuthToken()
  ]).then((_) {
    // Disable system bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Lock orientation to landscape only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    runApp(OmppuPad());
  });
}

class OmppuPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = ThemeBloc();
    return ThemeProvider(
      themeBloc: themeBloc,
      child: StreamBuilder<ThemeData>(
        stream: themeBloc.theme,
        builder: (_, snapshot) {
          return MaterialApp(
            title: 'Omppu Pad',
            theme: snapshot.data, 
            home: Dashboard(),
          );
        }
      ),
    );
  }
}
