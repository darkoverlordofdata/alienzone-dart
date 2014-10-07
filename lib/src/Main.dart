/**
 +--------------------------------------------------------------------+
 | Main.dart
 +--------------------------------------------------------------------+
 | Copyright DarkOverlordOfData (c) 2014
 +--------------------------------------------------------------------+
 |
 | This file is a part of alienzone
 |
 | alienzone is free software; you can copy, modify, and distribute
 | it under the terms of the MIT License
 |
 +--------------------------------------------------------------------+

 Alien Zone

 Match 3 Style Game
 */
part of alienzone;

/**
 * == Start ==
 *
 *   * Check if running with cordova
 *   * Start a game
 */
void start() {
  if (context['cordova'] != null) {
    cordova.Device.init()
    .then((device) => startGame(device))
    .catchError((ex, st) {
      print(ex);
      print(st);
      startGame(null);
    });
  }
  else startGame(null);
}


/**
 * == start game ==
 *
 *   * Hide the logo
 *   * Using game configuration
 *   * Start a game instance
 */
void startGame(device) {

  Dilithium.using("packages/alienzone/res").then((config) {
    querySelector('#logo').style.display = 'none';
    querySelector('body').style.backgroundColor = 'black';
    Game game = new Alienzone(config, device);
  });

}