import 'dart:async';

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double durationSeconds;
  final double progressSeconds;
  final bool isPlaying;

  ProgressBar({this.durationSeconds, this.progressSeconds, this.isPlaying});

  @override
  State<StatefulWidget> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double progress;

  Timer timer;
  @override
  void initState() {
    super.initState();
    progress = widget.progressSeconds;
    instantiateTimer();
  }

  instantiateTimer() {
    timer = Timer.periodic(Duration(seconds: 1), updateProgress);
  }

  updateProgress(Timer timer) {
    if (widget.isPlaying && ((progress + 1) < widget.durationSeconds)) {
      return this.setState(() => progress++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Theme.of(context).textTheme.body2.color,
      max: widget.durationSeconds,
      value: this.progress,
      divisions: widget.durationSeconds.toInt(),
      onChanged: (value) {
        timer.cancel();
        print('about to change slider value');
        this.setState(() => progress = value);
        //call API to update playback
        instantiateTimer();
      }
    );
  }
}