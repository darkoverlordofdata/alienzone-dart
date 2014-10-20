/**
 *--------------------------------------------------------------------+
 * Scores.dart
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
part of alienzone;

class Scores extends Li2State {

  /**
   * == Scores ==
   *   * Show the splash screen
   *   * Show the scores
   */

  Game parent;
  String text = "High Scores";

  var style = new TextStyle(font: "bold 20px Acme", fill: "#000");
  Sprite label;
  Li2Config config;

  Scores(this.parent, this.config);

  /**
   * State::create
   *
   * return	Nothing
   */
  create() {
    
    add
      ..sprite(0, 0, 'background')
      ..sprite(10, 10, 'icon');

    label = add.sprite(15, 125, 'scores');

    add
      ..text(120, 130, text, style)
      ..button(game.width / 2 - 38, game.height-45, 'backButton', goBack, this);

    label.alpha = 0.5;
}

  /**
   * Back
   *
   * return	Nothing
   */
  goBack(source, input, flag) {
    state.start(config.menu);
  }


}
