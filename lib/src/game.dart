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

class Game extends Li2.Dilithium implements CocoonListener {

  CocoonServices cocoon;
  GameUi ui;

  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(this.ui, Li2.Config config): super(config) {

    // screen.orientation.lock('portrait');
    print("Class Game initialized");
    cocoon = new CocoonServices(config, this);
    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
  }

  loginStatusChanged(object, value, error){

  }
  requestScore(object, value, error){

  }

  /**
   * Define each of the game states
   */
  Phaser.State levels() {

    game.state.add('infinity', new BaseLevel('infinity', config, cocoon, ui));
    game.state.add('ftl', new BaseLevel('ftl', config, cocoon, ui));
    game.state.add('gameover', new BaseLevel('gameover', config, cocoon, ui));
    game.state.add('achievements', new BaseLevel('achievements', config, cocoon, ui));
    game.state.add('leaderboards', new BaseLevel('leaderboards', config, cocoon, ui));

    ui.hideBanner();
    return new BaseLevel('main', config, cocoon, ui);

  }


}
