part of alienzone;

const String GROUP_STRINGS        = "STRINGS";

class StringEntity extends AbstractEntity {

  StringEntity(entities, int x, int y, String name, String font, String fill)
  : super(entities) {

    Artemis.Entity string = level.artemis.createEntity();
    string
    ..addComponent(new Position(x, y))
    ..addComponent(new Text(level.config.strings[name], font, fill))
    ..addComponent(new Immovable(true))
    ..addToWorld();
    groupManager.add(string, GROUP_STRINGS);
  }

}