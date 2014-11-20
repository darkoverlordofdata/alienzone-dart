part of alienzone;

const String GROUP_BACKGROUND = "BACKGROUND";

class BackgroundEntity extends AbstractEntity {

  BackgroundEntity(entities, int x, int y, String key)
  : super(entities) {

    Artemis.Entity background = level.artemis.createEntity();
    background.addComponent(new Sprite(x, y, key));
    groupManager.add(background, GROUP_BACKGROUND);
  }

}