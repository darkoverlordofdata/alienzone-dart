part of alienzone;

const String GROUP_BUTTONS      = "BUTTONS";

class ButtonEntity extends AbstractEntity {

  ButtonEntity(entities, int x, int y, String key, String state)
  : super(entities) {

    Artemis.Entity button = level.artemis.createEntity();
    button
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new State(state))
    ..addToWorld();
    groupManager.add(button, GROUP_BUTTONS);
  }

}