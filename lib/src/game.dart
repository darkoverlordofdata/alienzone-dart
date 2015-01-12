/**
 *--------------------------------------------------------------------+
 * game.dart
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

class Game extends Li2.Dilithium  {

  GameModel model;
  CocoonServices cocoon;

  GameServices services;
  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(Li2.Config config): super(config) {

    // screen.orientation.lock('portrait');
    print("Class Game initialized");
    cocoon = new CocoonServices(config, this);
    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
  }

  /**
   * Define each of the game states
   */
  Phaser.State levels() {

    game.state.add('game', new BaseLevel('game', config, cocoon));
    game.state.add('credits', new BaseLevel('credits', config, cocoon));
    game.state.add('gameover', new BaseLevel('gameover', config, cocoon));

    window.document.getElementById("logo").hidden = true;
    return new BaseLevel('main', config, cocoon);

  }


}
