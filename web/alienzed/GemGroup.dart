/*+--------------------------------------------------------------------+
#| GemGroup.coffee
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

class GemGroup {

  /**
   * GemGroup
   */
  var x               = 0;
  var currentPattern  = 0;
  var patterns;
  var gems;
  var level;
  
  /**
   * == New Gem Group ==
   *   * Create 2 random gems
   *   * Move, rotate and drop as a group
   *
   * param  [Phaser.GameState]  parent object
   * returns this
   */
  GemGroup(this.level) {
  
    x = 0;
    patterns = [
        new Pair(2, 1, new Pointe(0,0), new Pointe(0,1)),
        new Pair(2, 1, new Pointe(1,1), new Pointe(0,1)),
        new Pair(1, 2, new Pointe(0,1), new Pointe(0,0)),
        new Pair(1, 2, new Pointe(0,1), new Pointe(1,1))
    ];


    currentPattern = 0;

    // Create 2 gems
    gems = {
      'first'   : new Gem(level, level.randomGemType(), x + patterns[currentPattern].first.x, patterns[currentPattern].first.y),
      'second'  : new Gem(level, level.randomGemType(), x + patterns[currentPattern].second.x, patterns[currentPattern].second.y)
    };
  }
  /**
   * Update Positions method
   */
  updatePositions() {
    var pattern = patterns[currentPattern];
    gems["first"].move(x + pattern.first.x, pattern.first.y);
    gems["second"].move(x + pattern.second.x, pattern.second.y);
  }
  /**
   * Drop method
   */
  drop() {

    // Get the pattern
    var pattern = patterns[currentPattern];
    // Drop counter
    var dropped = 0;
    // gems to drop
    var gemsCount = pattern.order.length;
    // Drop gems in order

    pattern.order.forEach((i) {
      gems[i].drop((Sprite s){
        dropped += 1;
        // If all gems have been dropped
        if (dropped == gemsCount) {
          level.handleMatches();
        }

      });
    });
  }
  /**
   * Move method
   *
   * param  [Number]  deltaX {LEFT: -1, RIGHT: 1}
   * returns none
   */
  move(deltaX) {

    // new x position
    var newX = x + deltaX;
    // if current pattern is 1 or 3 max x is 4
    var maxX = (currentPattern == 1 || currentPattern == 3) ? 4 : 5;
    // if x is >= to 0 and <0 maxX
    // we can update x
    if (newX >= 0 && newX <= maxX)
      x = newX;
    // Update positions
    updatePositions();
  }
  /**
   * Rotate method
   *
   * param  [Number]  direction {LEFT: -1, RIGHT: 1}
   * returns none
   */
  rotate(direction) {

    // Update the current pattern
    currentPattern = currentPattern + direction;
    if (currentPattern >= patterns.length)
      currentPattern = 0;
    else if (currentPattern < 0)
      currentPattern = patterns.length-1;

    // If x is 5 and current pattern is 1 or 3
    // We must set x to 4
    if (x == 5 && (currentPattern == 1 || currentPattern == 3))
      x = 4;
    // Update positions
    updatePositions();
  }
}