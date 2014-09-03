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
import "package:alienzed/phaser.dart";

import "dart:html";
import 'dart:math';
import 'match3/match3.dart';

part "alienzed/Alienzed.dart";
part "alienzed/Gem.dart";
part "alienzed/GemGroup.dart";
part "alienzed/Start.dart";
part "alienzed/Intro.dart";
part "alienzed/Assets.dart";
part "alienzed/Levels.dart";
part "alienzed/GameOver.dart";



main() {

  querySelector('#logo').style.display = 'none';
  querySelector('body').style.backgroundColor = 'black';

  Game game = new Alienzed();


}
