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
  preload() {

    load // the assets
      //  start loading the Splash...
      ..setPreloadSprite(add.sprite(0, 0, 'splashScreen'))
      //  and then the remaining resources
      ..image('background',   'images/background.png')
      ..image('board',        'images/board.png')
      //  ui buttons
      ..image('startButton',  'images/start_button.png')
      ..image('arrow_right',  'images/arrows/right.png')
      ..image('arrow_left',   'images/arrows/left.png')
      ..image('arrow_down',   'images/arrows/down.png')
      ..image('arrow_lrot',   'images/arrows/lrot.png')
      ..image('arrow_rrot',   'images/arrows/rrot.png')
      // game pieces
      ..image('gem_blue',     'images/gems/blue.png')
      ..image('gem_cyan',     'images/gems/cyan.png')
      ..image('gem_green',    'images/gems/green.png')
      ..image('gem_magenta',  'images/gems/magenta.png')
      ..image('gem_orange',   'images/gems/orange.png')
      ..image('gem_pink',     'images/gems/pink.png')
      ..image('gem_red',      'images/gems/red.png')
      ..image('gem_yellow',   'images/gems/yellow.png');

  }

  create() {
    state.start('Intro', true, false);
    
  }

}
