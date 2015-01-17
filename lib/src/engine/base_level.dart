/**
 *--------------------------------------------------------------------+
 * base_level.dart
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

class BaseLevel extends Phaser.State {

  CocoonServices cocoon;
  GameUi ui;
  Artemis.World artemis;          // the ecs world
  Li2.Config config;              // dilithium config object
  Context context;                // the game context
  EntityFactory entityFactory;    // create entities
  SystemFactory systemFactory;    // create systems
  String level = "";              // current level name
  Math.Random random;             // random generator
  String name = "";               // state name
  String leaderboardId = "";
  int _score = 0;                 // score


  /**
   * Initialize the random generator
   */
  BaseLevel(this.level, this.config, this.cocoon, this.ui){
    if (DEBUG) print("Class BaseLevel initialized");
    random = new MersenneTwister();
    //random = new Math.Random(new DateTime.now().millisecondsSinceEpoch % 0x7fffffff);
    //random = new Math.Random();
  }

  /**
   * Initialize level parameters
   */
  void init([p]) {
    if (DEBUG) print("BaseLevel::init $level");
    leaderboardId = '';
    if (p != null) {
      name = p[0];
      _score = p[1];
      config.extra['leaderboards'].forEach((leaderboard) {
        if (leaderboard['title'].toLowerCase() == name) {
          leaderboardId = leaderboard['id'];
        }
      });
    }

  }

  /**
   * Create the world
   */
  void create() {

    context = new Context(this);
    artemis = new Artemis.World();
    artemis.addManager(new Artemis.GroupManager());
    artemis.addManager(new Artemis.TagManager());

    /**
     * Create the predefined entities for this level
     */
    entityFactory = new EntityFactory(this);
    config.levels[level]['entities'].forEach((entity) {
      entity.forEach((name, data){
        entityFactory.invoke(name, data);
      });
    });

    /**
     * Install systems for this level
     */
    systemFactory = new SystemFactory(this, cocoon);
    config.levels[level]['systems'].forEach((system) {
      system.forEach((name, active){
        var system = systemFactory.invoke(name);
        if (system == null)
          print("System not found: $name");
        else
          artemis.addSystem(system, passive: !active);
      });
    });

    artemis.initialize();
    context.updateScore(0);
  }

  /**
   * Game Loop
   */
  void update() {
    artemis.delta = game.time.elapsed;
    artemis.process();
  }

  void gameover() {
    state.start("gameover", true, false, [name, context.score]);

  }
}