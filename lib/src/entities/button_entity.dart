part of alienzone;

const String GROUP_BUTTONS      = "BUTTONS";

class ButtonEntity extends AbstractEntity {

  ButtonEntity(entities, int x, int y, String key, String action, [String text = "", String font = "", String fill = ""])
  : super(entities) {

    Artemis.Entity button = level.artemis.createEntity();
    button
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new Action(action))
    ..addComponent(new Text(text, font, fill))
    ..addToWorld();
    groupManager.add(button, GROUP_BUTTONS);
  }

}