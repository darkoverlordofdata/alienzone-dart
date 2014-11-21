part of alienzone;

class BaseLevel extends Phaser.State {

  Artemis.World artemis;        // the ecs world
  Li2Config config;             // dilithium config object
  Context context;              // the game context
  EntityFactory entityFactory;  // create entities
  SystemFactory systemFactory;  // create systems
  String level = "";            // current level name


  BaseLevel(this.level, this.config);

  void init([p]) {

    print("BaseLevel::init $level");

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
        print("Create entity: $name");
        entityFactory.invoke(name, data);
      });
    });

    /**
     * Install systems for this level
     */
    systemFactory = new SystemFactory(this);
    config.levels[level]['systems'].forEach((entity) {
      entity.forEach((name, passive){
        print("Create system: $name");
        artemis.addSystem(systemFactory.invoke(name), passive: passive);
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