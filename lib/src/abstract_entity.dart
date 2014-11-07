part of alienzone;

abstract class AbstractEntity {

  Phaser.Game game;
  World world;
  GroupManager groupManager;
  TagManager tagManager;

  AbstractEntity(EntityFactory entities) {
    game = entities.game;
    world = entities.world;
    groupManager = entities.groupManager;
    tagManager = entities.tagManager;
  }

}

