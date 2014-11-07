part of alienzone;

const String GROUP_BACKGROUND = "BACKGROUND";

class BackgroundEntity extends AbstractEntity {

  BackgroundEntity(entities, int x, int y, String key) : super(entities) {
    Entity background = world.createEntity();
    background.addComponent(new Sprite(x, y, key));
    groupManager.add(background, GROUP_BACKGROUND);
  }

}