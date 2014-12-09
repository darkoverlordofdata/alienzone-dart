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

  Artemis.World artemis;          // the ecs world
  Li2Config config;               // dilithium config object
  Context context;                // the game context
  EntityFactory entityFactory;    // create entities
  SystemFactory systemFactory;    // create systems
  String level = "";              // current level name
  MersenneTwister random;         // PRNG
  String name = "";
  int _score = 0;


  /**
   * Initialize the random generator
   */
  BaseLevel(this.level, this.config){
    if (DEBUG) print("Class BaseLevel initialized");
    random = new MersenneTwister();
    // shuffle the deck...
//    int x = ((random.genrand_real2() * new DateTime.now().millisecond)/Math.PI).floor();
//    for (int i=0; i<x; i++) {
//      random.genrand_real2();
//    }
  }

  /**
   * Initialize level parameters
   */
  void init([p]) {
    if (DEBUG) print("BaseLevel::init $level");
    if (p != null) {
      name = p[0];
      _score = p[1];
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
    systemFactory = new SystemFactory(this);
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
  }

  /**
   * Game Loop
   */
  void update() {
    artemis.delta = game.time.elapsed;
    artemis.process();
  }
}