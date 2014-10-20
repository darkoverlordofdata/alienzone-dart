/**
 *--------------------------------------------------------------------+
 * Credits.dart
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

class Credits extends Li2State {

  /**
   * == Credits ==
   *   * Show the splash screen
   *   * Shoe Credits
   */

  var quoteStyle = new TextStyle(font: "italic 12px Arial", fill: "#000");
  var style = new TextStyle(font: "12px Arial", fill: "#000");
  var cstyle = new TextStyle(font: "14px Arial", fill: "#fff");
  Sprite label;

  Li2Config config;

  Credits(Li2Config this.config);

  /**
   * State::create
   *
   * return	Nothing
   */
  create() {
    
    add
      ..sprite(0, 0, 'background')
      ..sprite(10, 10, 'icon');

    label = add.sprite(10, 320, 'label');

    add
      ..text(20, 335, config.strings['creditsText'], style)
      ..button(game.width / 2 - 38, game.height-75, 'backButton', goBack, this)
      ..text(50, game.height-30, config.strings['copyrightText'], cstyle);

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