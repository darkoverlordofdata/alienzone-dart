/*+--------------------------------------------------------------------+
#| main.dart
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of alienzed
#|
#| alienzed is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# Alien Zed
#
#   Match 3 Style Game
*/
library alienzed;


import "dart:async";
import "dart:html";
import 'dart:math';
import 'dart:js';

import "package:alienzed/phaser.dart";
import 'package:rikulo_gap/device.dart' as cordova;

import 'match3/match3.dart';
part "alienzed/Alienzed.dart";
part "alienzed/Gem.dart";
part "alienzed/GemGroup.dart";
part "alienzed/Start.dart";
part "alienzed/Intro.dart";
part "alienzed/Assets.dart";
part "alienzed/Levels.dart";
part "alienzed/GameOver.dart";



void main() {
  if (context['cordova'] != null) {
    cordova.Device.init()
    .then((device)=> startGame(device))
    .catchError((ex, st) {
      print(ex);
      print(st);
    });
  }
  else startGame(null);
}


void startGame(device) {
  querySelector('#logo').style.display = 'none';
  querySelector('body').style.backgroundColor = 'black';
  Game game = new Alienzed(device);
}