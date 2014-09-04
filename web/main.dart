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
import 'dart:async' as async;
import "package:alienzed/phaser.dart";
import 'package:js/js.dart' as js;
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


//  new async.Timer(const Duration(milliseconds: 1000), () => start());
  querySelector('#logo').style.display = 'none';
  querySelector('body').style.backgroundColor = 'black';
  print("create new game.0");
  Game game = new Alienzed();
  print("create new game.1");

}

void start() {
}