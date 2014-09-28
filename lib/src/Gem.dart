/**
 +--------------------------------------------------------------------+
 | Gem.dart
 +--------------------------------------------------------------------+
 | Copyright DarkOverlordOfData (c) 2013
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

class Gem extends MatchObject {

  /**
   * Gem Class
   */

  int x;
  int y;
  Sprite sprite;
  State level;

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
  Gem(State this.level, String type, int this.x, int this.y) : super(type) {
    sprite = level.add.sprite(0, 0, "gem_$type");
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
    sprite.x = x * Alienzone.GEMSIZE;
    sprite.y = y * Alienzone.GEMSIZE;
  }
  /**
   * Drop method
   *
   * param  [Function]  next function
   * returns none
   */
  void drop(next) {
    // Get the gem column
    List column = level.grid.getColumn(x, 1);
    // Get the last empty piece to place the gem
    Piece lastEmpty = Grid.getLastEmptyPiece(column);
    // If an empty piece has been found
    if (lastEmpty != null) {
      // Bind this gem to the piece
      lastEmpty.object = this;
      // And make it fall
      fall(lastEmpty.x, lastEmpty.y, next);
    }
    else {
      // Game Over
      level.gameOver();
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
   // next = next or ()->
    // Create a tween animation
    var point = {
        'x': x * Alienzone.GEMSIZE,
        'y': Alienzone.MARGINTOP * Alienzone.GEMSIZE + y * Alienzone.GEMSIZE
    };

    level.add.tween(sprite)
    .to(point, 750, Easing.Bounce.Out, true, 0, 0, false)
    .onComplete.add(next);
  }
}