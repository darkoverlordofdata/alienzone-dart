/**
 *--------------------------------------------------------------------+
 * player_control_system.dart
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

class PlayerControlSystem extends Artemis.VoidEntitySystem {


  /**
   * Move a group of 1-4 gems on a 2 x 6 grid.
   * A gem group occupies 2 or 4 adjacent cells.
   * Position and drop the group onto the puzzle area.
   * Puzzle area is a 7 x 6 grid
   *
   *    0   1   2   3   4   5
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 0
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 1
   *  +---+---+---+---+---+---+
   *  +===+===+===+===+===+===+
   *  |   |   |   |   |   |   | 0
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 1
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 2
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 3
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 4
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 5
   *  +---+---+---+---+---+---+
   *  |   |   |   |   |   |   | 6
   *  +---+---+---+---+---+---+
   */


  int rot = 0;            //  rotate frame (0-3)
  int pos = 0;            //  horizontal cursor (0-4)
  int offset = 0;         //  display offset
  int board = 0;          //  level up board number
  int count = 2;          //  # of crystals
  int known = 3;          //  start off with set of 3 crystals
  int discovered = 0;     //  we discover the remaining crystals
  bool dropping = false;  //  crystals being dropped?
  CocoonServices cocoon;
  BaseLevel level;        //  parent game state
  List discoveredGems;    //  all the discovered crystals
  List<Gem> gems;         //  group of crystals that move on the top board
  Match3.Grid puzzle;     //  the 7 x 6 puzzle grid
  List maps = [           //  crystal rotation maps:
      [[[1,0],[0,0]], [[0,1],[0,0]], [[0,0],[0,1]], [[0,0],[1,0]]],
      [[[1,0],[2,0]], [[2,1],[0,0]], [[0,2],[0,1]], [[0,0],[1,2]]],
      [[[1,0],[2,3]], [[2,1],[3,0]], [[3,2],[0,1]], [[0,3],[1,2]]],
      [[[1,4],[2,3]], [[2,1],[3,4]], [[3,2],[4,1]], [[4,3],[1,2]]]
  ];


  PlayerControlSystem(this.level, this.cocoon);


  /**
   * Initialize player control
   */
  void initialize() {
    if (DEBUG) print("PlayerControlSystem::initialize");

    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Action> actionMapper = new Artemis.ComponentMapper<Action>(Action, level.artemis);

    groupManager.getEntities(GROUP_INPUTS).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      Action action = actionMapper.get(entity);
      level.add.button(sprite.x, sprite.y, sprite.key,
        (source, input, flag) {
          switch(action.name) {
            case 'left': return move(-1);
            case 'right': return move(1);
            case 'drop': return drop();
            case 'lrot': return rotate(-1);
            case 'rrot': return rotate(1);
          }
        });
    });

    discoveredGems = [];
    for (int i=0; i<Gem.GEMTYPES.length; i++) {
      if (i < (discovered+known)) {
        discoveredGems.add(Gem.GEMTYPES[i]);
      }
    }
    puzzle = new Match3.Grid(width: 6, height: 7, gravity: 'down');
    createGems();

    level.context.action.add(onTimer);
  }

  onTimer(String name) {

    if (name == 'gem-drop') {
      drop();
    }
  }

    /**
   * New Gem Group
   *
   * return Gem Group
   */
  void createGems() {

    int i = Math.max(2, ((count+level.context.legend)/2).floor())-1;
    List cursor = maps[i][0];
    gems = [];
    rot = 0;
    pos = 0;
    offset = 0;

    for (int row = 0; row < 2; row++) {
      for (int col = 0; col < 2; col++) {
        if (cursor[row][col] != 0) {

          int frame = (level.random.nextDouble() * discoveredGems.length).floor();
          GemEntity entity = level.entityFactory.gem(col, row, 'gems', frame);
          gems.add(new Gem(this, Gem.GEMTYPES[frame], col, row));

        }
      }
    }
    update();
    level.context.reset.dispatch();
  }

  /**
   * Update Score
   *
   * return none
   */
  updateScore(List matches, String type) {
    int points = (Gem.GEMTYPES.indexOf(type) + 1) * matches.length * (board+1);
    level.context.updateScore(points);
  }

  /**
   * Drop
   *
   * drop the gems onto the puzzle
   */
  void drop() {
    if (dropping) return;
    dropping = true;
    // Drop counter
    int dropped = 0;

    List cursor = maps[gems.length-1][rot];

    /**
     * take off in the reverse order
     */
    for (int row = 1; row>=0; row--) {
      for (int col = 1; col>=0; col--) {
        if (cursor[row][col] != 0) {
          gems[cursor[row][col]-1].drop((Sprite s){
            dropped += 1;
            // If all gems have been dropped
            if (dropped == gems.length) {
              handleMatches();
              dropping = false;
            }
          });
        }
      }
    }

  }

  /**
   * Move
   *
   * move the gems left or right
   */
  void move(dir) {
    if (pos+dir >= 0 && pos+dir <=5) {
      pos += dir+offset;
      offset = 0;
      update();
      return;
    }

    if (pos+dir < 0) {
      if (gems.length == 2 && rot == 2) {
        offset = -1;
        update();
        return;
      }
    }
  }

  /**
   * Rotate
   *
   * rotate the gems left or right
   */
  void rotate(dir) {
    if (offset == -1) return;
    if (pos>=5) return;
    rot += dir;
    if (rot < 0) rot = 3;
    if (rot > 3) rot = 0;
    update();
  }

  /**
   * Update
   *
   * update the gem sprite position
   */
  void update() {

    List cursor = maps[gems.length-1][rot];
    for (int row = 0; row<2; row++) {
      for (int col = 0; col<2; col++) {
        if (cursor[row][col] != 0) {
            gems[cursor[row][col]-1].move(Math.max(0, Math.min(5, pos+col+offset)), row);
        }
      }
    }
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
    var matches = puzzle.getMatches();
    if (matches != null) {
      // Initialize the array of pieces to upgrade
      piecesToUpgrade = [];
      // Reference to the current game
      // For each match found
      puzzle.forEachMatch((matchingPieces, type) {
        // Add to score
        updateScore(matchingPieces, type);
        // For each match take the first piece to upgrade it
        piecesToUpgrade.add({
//            'piece'   : matchingPieces[0],
            'type'    : type
        });
        matchingPieces.forEach((matchingPiece) {
          // Destroy each piece
          level.add.tween(matchingPiece.object.sprite)
          .repeat(6)
          .to({'alpha':0}, 150, Phaser.Easing.Linear.None, true, 0, 0, true)
          .onComplete.add((Phaser.Sprite s) => s.destroy());
        });
      });

      // Remove matches and apply Gravity
      puzzle.clearMatches();
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
    var fallingPieces = puzzle.applyGravity();
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
      createGems();
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
      int upgradeIndex = Gem.GEMTYPES.indexOf(pieceToUpgrade['type']) + 1;
      if (upgradeIndex >= Gem.GEMTYPES.length-1) {
        /**
         * Level Up...
         */
        level.state.start(level.name, true, false, [level.name, level.context.score]);
        return;

      }
      if (level.context.legend < upgradeIndex) {
        levelUp = true;
      }
      level.context.legend = upgradeIndex;
      String upgradedType = Gem.GEMTYPES[upgradeIndex];
      // If the type is defined
      if (upgradedType != null) {
        // And if the type is not already discovered
        if (discoveredGems.indexOf(upgradedType) == -1)
          // Push it to discovered gems array
          discoveredGems.add(upgradedType);
      }
    });
    if (levelUp) {
      board += 1;
    }
  }

  void gameover() {
    level.gameover();
  }

  void processSystem() {
  }
}
