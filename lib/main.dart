// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(CountdownTimer());

class RingTimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class CountdownTimer extends StatefulWidget {
  @override
  CountdownTimerState createState() {
    return CountdownTimerState(5);
  }
}

class CountdownTimerState extends State<StatefulWidget> {
  static AudioCache player = AudioCache();
  int duration = 60;
  DateTime start;
  var timeString = "00:00";
  Timer timer = null;

  CountdownTimerState(int duration){
    this.duration = duration;
  }

  @override
  void initState() {
    start = DateTime.now();
    timeString = "03:00";
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTimer(t));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Ring Timer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(timeString,
            style: new TextStyle(
                fontSize: 80.0
              ))
                 // ,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0))
            ],
          ),
        ),
      ),
    );
  }

  void _updateTimer(Timer t) {
    Duration sinceStart = DateTime.now().difference(start);
    int remaining = duration - sinceStart.inSeconds;
    /*
    Trying to play sounds with:
    https://github.com/luanpotter/audioplayers/blob/master/doc/audio_cache.md
     */
    if(remaining <= 0)player.play("bell.opus");
    setState(() {
      timeString = formatSeconds(remaining);
    });
  }

  String formatSeconds(int s){
    if(s < 0)return "00:00";
    return ((s/600).floor()%10).toString() + ((s/60).floor()%10).toString()
        + ":" + ((s/10).floor()%10).toString() + ((s).floor()%10).toString();
  }

  /*
  @override
  void dispose() {
    if(timer != null) timer.cancel();
    super.dispose();
  }
   */
}