part of alienzone;

const String GROUP_INPUTS      = "INPUTS";

class InputEntity extends AbstractEntity {

  InputEntity(entities, int x, int y, String key, String action)
  : super(entities) {

    Artemis.Entity input = level.artemis.createEntity();
    input
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new Action(action))
    ..addToWorld();
    groupManager.add(input, GROUP_INPUTS);
  }

}