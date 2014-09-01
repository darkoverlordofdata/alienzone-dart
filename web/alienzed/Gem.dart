/*+--------------------------------------------------------------------+
#| Gem.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2013
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

class Gem {

  /**
   * Gem Class
   */

  Sprite sprite;
  int x;
  int y;
  var level;
  var type;

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
  Gem(this.level, this.type, this.x, this.y) {
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
  move(x, y) {
    this.x = x;
    this.y = y;
    sprite.x = x * Alienzed.GEMSIZE;
    sprite.y = y * Alienzed.GEMSIZE;
  }
  /**
   * Drop method
   *
   * param  [Function]  next function
   * returns none
   */
  drop(next) {
    // Get the gem column
    var column = level.grid.getColumn(x, 1);
    // Get the last empty piece to place the gem
    var lastEmpty = Grid.getLastEmptyPiece(column);
    // If an empty piece has been found
    if (lastEmpty) {
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
  fall(x, y, next) {
   // next = next or ()->
    // Create a tween animation
    level.add.tween(sprite)
    .to({
      x: x * Alienzed.GEMSIZE,
      y: Alienzed.MARGINTOP * Alienzed.GEMSIZE + y * Alienzed.GEMSIZE}
    , 500, Easing.Bounce.Out, true)
    .onComplete.add(next);
  }
}