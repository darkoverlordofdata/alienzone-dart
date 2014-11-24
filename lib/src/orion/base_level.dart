part of alienzone;

class BaseLevel extends Phaser.State {

  Artemis.World artemis;        // the ecs world
  Li2Config config;             // dilithium config object
  Context context;              // the game context
  EntityFactory entityFactory;  // create entities
  SystemFactory systemFactory;  // create systems
  String level = "";            // current level name
  Math.Random random;


  BaseLevel(this.level, this.config){
    random = new Math.Random();
    // shuffle the deck
    DateTime d = new DateTime.now();
    int s = (d.millisecond / Math.PI).floor();
    for (int i=0; i<s; i++) {
      random.nextInt(s-i);
    }
  }

  void init([p]) {
    if (DEBUG) print("BaseLevel::init $level");
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