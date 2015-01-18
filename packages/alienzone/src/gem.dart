/**
 *--------------------------------------------------------------------+
 * gem.dart
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

class Gem extends Match3.MatchObject {

  static const GEMSIZE    = 48;     // Gem size constant in pixels
  static const MARGINTOP  = 2;      // Margin top equal to 2 gems height
  static final List GEMTYPES = [    // All gem types:
      "blue",
      "cyan",
      "green",
      "magenta",
      "orange",
      "pink",
      "red",
      "yellow"
  ];

  /**
   * Gem Class -
   *
   * a bridge to the Match3 game logic module
   */

  int x;
  int y;
  Phaser.Sprite sprite;
  PlayerControlSystem player;

  /**
   * == New Gem ==
   *   * Set the sprite
   *   * Set the initial position
   *
   * param  [Phaser.GameState]  parent object
   * param  [String]  gem type
   * param  [Number]  x coordinate
   * param  [Number]  y coordinate
   * returns this
   */
  Gem(this.player, String type, this.x, this.y) : super(type) {

    sprite = player.level.add.sprite(0, 0, 'gems', GEMTYPES.indexOf(type));
    move(x, y);
  }
  /**
   * Move method
   *
   * param  [Number]  x coordinate
   * param  [Number]  y coordinate
   * returns none
   */
  void move(int x, int y) {
    this.x = x;
    this.y = y;
    sprite.x = x * GEMSIZE;
    sprite.y = y * GEMSIZE;
  }
  /**
   * Drop method
   *
   * param  [Function]  next function
   * returns none
   */
  void drop(next) {
    // Get the gem column
    List column = player.puzzle.getColumn(x, false);
    // Get the last empty piece to place the gem
    Match3.Piece lastEmpty = Match3.Grid.getLastEmptyPiece(column);
    // If an empty piece has been found
    if (lastEmpty != null) {
      // Bind this gem to the piece
      lastEmpty.object = this;
      // And make it fall
      fall(lastEmpty.x, lastEmpty.y, next);
    }
    else {
      // Game Over
      player.gameover();
    }
  }
  /**
   * Fall method
   *
   * param  [Number]  x coordinate
   * param  [Number]  y coordinate
   * param  [Function]  next function
   * returns none
   */
  void fall(int x, int y, next) {

    // Create a tween animation
    var point = {
        'x': x * GEMSIZE,
        'y': y * GEMSIZE + MARGINTOP * GEMSIZE
    };

    player.level.add.tween(sprite)
    .to(point, 750, Phaser.Easing.Bounce.Out, true, 0, 0, false)
    .onComplete.add(next);
  }
}