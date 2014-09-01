/*+--------------------------------------------------------------------+
#| index.coffee
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


part "match3/VoidObject.dart";
part "match3/Piece.dart";
part "match3/Grid.dart";
//
part "alienzed/Alienzed.dart";
part "alienzed/Assets.dart";
part "alienzed/GameOver.dart";
part "alienzed/Gem.dart";
part "alienzed/GemGroup.dart";
part "alienzed/Initialize.dart";
part "alienzed/Level1.dart";
part "alienzed/Levels.dart";



main() {

  querySelector('#logo').style.display = 'none';
  querySelector('body').style.backgroundColor = 'black';

  Game game = new Alienzed();


}
