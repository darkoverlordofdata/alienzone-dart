/**
 *--------------------------------------------------------------------+
 * Levels.dart
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

class Levels extends Li2State {

  static const SFX_COUNT = 19;
  /**
   * Members
   */

  Game parent;
  Phaser.Sprite background;
  Phaser.Sprite board;
  Grid grid;
  Phaser.Sprite startButton;
  Phaser.Text text;
  List discoveredGems;
  GemGroup gemGroup;
  List<Phaser.Sound> bonus = [];
  List<Phaser.Sprite> legend = [];
  Li2Config config;
  int score = 0;
  int level = 0;

  Levels(this.parent, this.config);

  /**
   * Init -
   *
   * receive arguments from prior level
   */
  init([args]) {

    if (args == null) {
      level = 0;
      score = 0;
    } else {
      level = args[0];
      score = args[1];
    }

    print("New Level: $level, $score");

  }

  /**
   * == Create the game level
   *   * set the background and game board
   *   * draw the text
   *   * wire up the buttons
   *
   * return none
   */
  create() {

    time.advancedTiming = true;
    background = add.sprite(0, 0, 'background');
    board = add.sprite(0, 0, 'board');
    board.alpha = 0.7;

    for (var i=1; i<=SFX_COUNT+1; i++) {
      bonus.add(add.audio("bonus$i"));
    }

    game.sound.volume = parent.soundfx;

    discoveredGems = [];
    for (var i=0; i<Game.GEMTYPES.length; i++) {
      Phaser.Sprite s = add.sprite(290, 100+(i*32), "legend", i);
      if (i <= (level+2)) {
        discoveredGems.add(Game.GEMTYPES[i]);
      } else {
        s.alpha = 0.2;
      }
      legend.add(s);
    }

    text = add.text(100, 20, "Score: $score", new Phaser.TextStyle(font: "bold 30px Acme",fill: "#e0e0e0"));
    grid = new Grid(width: 6, height: 7, gravity: 'down');

    newGemGroup();
    add // ui components
      ..button(260,  20, 'backButton',  goBack,       this)
      ..button(  0, 420, 'arrow_left',  leftButton,   this)
      ..button( 50, 420, 'arrow_down',  dropButton,   this)
      ..button(100, 420, 'arrow_right', rightButton,  this)
      ..button(210, 420, 'arrow_lrot',  lrotButton,   this)
      ..button(260, 420, 'arrow_rrot',  rrotButton,   this);
  }
  
  /**
   * Directional Handlers
   *
   * return none
   */
  leftButton(source, input, flag) {
    gemGroup.move(-1);
  }
  
    
  rightButton(source, input, flag) {
    gemGroup.move(1);
  }
    
  lrotButton(source, input, flag) {
    gemGroup.rotate(-1);
  }
    
  rrotButton(source, input, flag) {
    gemGroup.rotate(1);
  }
    
  dropButton(source, input, flag) {
    gemGroup.drop();
    gemGroup = null;
  }

  goBack(source, input, flag) {
    state.start(config.menu);
  }

  /**
   * New Gem Group
   *
   * return Gem Group
   */
  newGemGroup() {
    gemGroup = new GemGroup(this);
  }

  /**
   * Handle Matches
   *
   * return none
   */
  handleMatches() {

    var piecesToUpgrade;
    // Get all matches
    // If matches have been found
    var matches = grid.getMatches();
    if (matches != null) {
      // Initialize the array of pieces to upgrade
      piecesToUpgrade = [];
      // Reference to the current game
      // For each match found
      grid.forEachMatch((matchingPieces, type) {
        // Add to score
        updateScore(matchingPieces, type, "#ff0");
        // For each match take the first piece to upgrade it
        piecesToUpgrade.add({
          'piece'   : matchingPieces[0],
          'type'    : type
        });
        matchingPieces.forEach((matchingPiece) {
          // Destroy each piece
          add.tween(matchingPiece.object.sprite)
          .repeat(6)
          .to({'alpha':0}, 150, Phaser.Easing.Linear.None, true, 0, 0, true)
          .onComplete.add((Phaser.Sprite s) => s.destroy());
        });
      });

      // Remove matches and apply Gravity
      grid.clearMatches();
      // Upgrade pieces
      handleUpgrade(piecesToUpgrade);
    }
    handleFalling();
  }

  /**
   ^ Handle Falling
   ^
   ^ return none
   */
  handleFalling() {

    // Apply gravity and get falling Pieces
    var fallingPieces = grid.applyGravity();
    var hasFall;

    if (fallingPieces.length > 0) {
      // Falling counter
      hasFall = 0;
      // For each falling pieces
      fallingPieces.forEach((piece) {
        piece.object.fall(piece.x, piece.y, (Sprite s) {
          hasFall += 1;
          if (hasFall == fallingPieces.length)
            handleMatches();
        });
      });
    } else {
      // Create a new gem if no falling pieces
      newGemGroup();
    }
  }
  /**
   * Handle Upgrade
   *
   * return none
  */
  handleUpgrade(piecesToUpgrade) {

    bool levelUp = false;

    // For each piece to upgrade
    piecesToUpgrade.forEach((pieceToUpgrade) {
      // Get the upgraded type
      var upgradeIndex = Game.GEMTYPES.indexOf(pieceToUpgrade['type']) + 1;
      if (upgradeIndex >= Game.GEMTYPES.length-1) {
        /**
         * Level Up...
         */
        state.start("Levels", true, false, [0, score]);

      }
      if (legend[upgradeIndex].alpha < 1.0) {
        levelUp = true;
      }
      legend[upgradeIndex].alpha = 1.0;
      var upgradedType = Game.GEMTYPES[upgradeIndex];
      // If the type is defined
      if (upgradedType != null) {
        // And if the type is not already discovered
        if (discoveredGems.indexOf(upgradedType) == -1)
          // Push it to discovered gems array
          discoveredGems.add(upgradedType);
      }
    });
    if (levelUp) {
      level += 1;
    }
  }

  /**
   * Random Gem Type
   *
   * return string - random gem type
   */
  randomGemType() {

    var i = rnd.integerInRange(0, discoveredGems.length-1);
    return discoveredGems[i];
  }

  /**
   * Update Score
   *
   * return none
   */
  updateScore(List matches, String type, String color) {

    int speed = 1000;
    var dur = const Duration(milliseconds: 1000);
    var scoreStyle = new Phaser.TextStyle(font: "bold 120px Courier New, Courier",fill: color, align: "center");
    var points = (Game.GEMTYPES.indexOf(type) + 1) * matches.length * (level+1);

    score += points;
    text.text = "Score: $score";
    text.updateText();

    Phaser.Text popup = add.text(90, 300, "$points", scoreStyle);
    bonus[points % SFX_COUNT].play();

    add.tween(popup)
    .to({'alpha': 1}, (speed*0.75).toInt(), Phaser.Easing.Linear.None, true)
    .to({'alpha': 0}, (speed*0.25).toInt(), Phaser.Easing.Linear.None, true);

    new async.Timer(dur, ()=> world.remove(popup));

  }

  /**
   * No more room
   *
   * return none
   */
  noRoom() {
    gameOver();
  }
  /**
   * Game Over
   *
   * return none
   */
  gameOver() {
    state.start("GameOver", false, false);
  }

}