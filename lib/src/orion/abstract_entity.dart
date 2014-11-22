part of alienzone;

abstract class AbstractEntity {

  BaseLevel level;
  Artemis.GroupManager groupManager;
  Artemis.TagManager tagManager;

  AbstractEntity(EntityFactory entities) {
    level = entities.level;
    groupManager = entities.groupManager;
    tagManager = entities.tagManager;
  }

}

