part of alienzone;

class PlayerControlSystem extends Artemis.VoidEntitySystem {


  /**
   * Move a group of 1-4 gems on a 2 x 6 puzzle.
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


  int rot = 0;          //  rotate frame (0-3)
  int pos = 0;          //  horizontal cursor (0-4)
  int board = 0;        //  level up board number
  int known = 3;        //  start off with 3 gems
  int discovered = 0;   //  we discover the remaining gems
  BaseLevel level;      //  parent game state
  List discoveredGems;  //  all the discovered gems
  List<Gem> gems;       //  group of gems that move on the top board
  Match3.Grid puzzle;   //  the 7 x 6 puzzle grid
  List maps = [         //  Gem rotation maps:
      [[[1,0],[0,0]], [[0,1],[0,0]], [[0,0],[0,1]], [[0,0],[1,0]]],
      [[[1,0],[2,0]], [[2,1],[0,0]], [[0,2],[0,1]], [[0,0],[1,2]]],
      [[[1,0],[2,3]], [[2,1],[3,0]], [[3,2],[0,1]], [[0,3],[1,2]]],
      [[[1,4],[2,3]], [[2,1],[3,4]], [[3,2],[4,1]], [[4,3],[1,2]]]
  ];


  PlayerControlSystem(this.level);


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
    for (var i=0; i<Game.GEMTYPES.length; i++) {
      if (i < (discovered+known)) {
        discoveredGems.add(Game.GEMTYPES[i]);
      }
    }
    puzzle = new Match3.Grid(width: 6, height: 7, gravity: 'down');
    createGems();
  }

  /**
   * New Gem Group
   *
   * return Gem Group
   */
  void createGems([int count = 2]) {

    List cursor = maps[count-1][0];
    gems = [];
    rot = 0;
    pos = 0;

    for (int row = 0; row < 2; row++) {
      for (int col = 0; col < 2; col++) {
        if (cursor[row][col] != 0) {

          int frame = level.random.nextInt(discoveredGems.length);
          GemEntity entity = level.entityFactory.gem(col, row, 'gems', frame);
          gems.add(new Gem(this, Game.GEMTYPES[frame], col, row));

        }
      }
    }
  }

  /**
   * Update Score
   *
   * return none
   */
  updateScore(List matches, String type) {
    var points = (Game.GEMTYPES.indexOf(type) + 1) * matches.length * (board+1);
    //level.context.score += points;
    level.context.updateScore(points);
  }

  /**
   * Drop
   *
   * drop the gems onto the puzzle
   */
  void drop() {
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
    if (pos+dir >= 0 && pos+dir <=4) {
      pos += dir;
      update();
      return;
    }

    if (pos+dir < 0) {
      if (gems.length == 2 && rot == 2) {
        rot = 0;
        update();
        return;
      }
    }

    if (pos+dir > 4) {
      if (gems.length == 2 && rot == 0) {
        rot = 2;
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
            gems[cursor[row][col]-1].move(pos+col, row);
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
            'piece'   : matchingPieces[0],
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
      var upgradeIndex = Game.GEMTYPES.indexOf(pieceToUpgrade['type']) + 1;
      if (upgradeIndex >= Game.GEMTYPES.length-1) {
        /**
         * Level Up...
         */
        level.state.start("game", true, false, [0, level.context.score]);

      }
      if (level.context.legend < upgradeIndex) {
        levelUp = true;
      }
      level.context.legend = upgradeIndex;
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
      board += 1;
    }
  }

  void gameover() {

  }

  void processSystem() {
  }
}
