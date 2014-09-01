/*+--------------------------------------------------------------------+
#| Assets.dart
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
# Load the game assets
*/
part of alienzed;

class Assets extends State {

  /**
   * == Assets ==
   *   * Show the splash screen
   *   * Load the game assets
   */
  var splashScreen;

  preload() {

    //  Splash...
    splashScreen = add.sprite(0, 0, 'splashScreen');
    load.setPreloadSprite(splashScreen);

    //  Start loading the remaining game assets
    load.image('startButton',  'images/start_button.png');
    load.image('background',   'images/background.png');
    load.image('board',        'images/board.png');

    load.image('arrow_right',  'images/arrows/right.png');
    load.image('arrow_left',   'images/arrows/left.png');
    load.image('arrow_down',   'images/arrows/down.png');
    load.image('arrow_lrot',   'images/arrows/lrot.png');
    load.image('arrow_rrot',   'images/arrows/rrot.png');

    load.image('gem_blue',     'images/gems/blue.png');
    load.image('gem_cyan',     'images/gems/cyan.png');
    load.image('gem_green',    'images/gems/green.png');
    load.image('gem_magenta',  'images/gems/magenta.png');
    load.image('gem_orange',   'images/gems/orange.png');
    load.image('gem_pink',     'images/gems/pink.png');
    load.image('gem_red',      'images/gems/red.png');
    load.image('gem_yellow',   'images/gems/yellow.png');

  }

  create() {
    state.start('Levels', true, false);
    
  }

}
