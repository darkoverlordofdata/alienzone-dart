/*+--------------------------------------------------------------------+
#| Credits.dart
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
part of alienzed;

class Credits extends State {

  String text = """
Program by darkoverlordofdata
Background Graphics - http://www.nasa.gov
Gems: http://opengameart.org/content/gem-tiles
Based on: https://github.com/hugeen/createjs_match3
  """;

  String inspiration = "https://github.com/hugeen/createjs_match3";
  String copyright = "Copyright 2014 Dark Overlord of Data";

  var quoteStyle = new TextStyle(font: "italic 12px Arial", fill: "#000");
  var style = new TextStyle(font: "12px Arial", fill: "#000");
  var cstyle = new TextStyle(font: "14px Arial", fill: "#fff");
  Sprite label;

  /**
   * Phaser.State::create
   *
   * return	Nothing
   */
  create() {
    
    add
      ..sprite(0, 0, 'background')
      ..sprite(10, 10, 'icon');

    label = add.sprite(10, 320, 'label');

    add
      ..text(20, 335, text, style)
      ..button(game.width / 2 - 38, game.height-75, 'backButton', goBack, this)
      ..text(50, game.height-30, copyright, cstyle);

    label.alpha = 0.5;
}

  /**
   * Phaser.State::update
   *
   * return	Nothing
   */
  goBack(source, input, flag) {
    state.start('Intro', true, false);
  }


}
