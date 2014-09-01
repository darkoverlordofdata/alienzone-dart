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
  print("start");

  querySelector('#logo').style.display = 'none';
  querySelector('body').style.backgroundColor = 'black';

  Game game = new Alienzed();


}
