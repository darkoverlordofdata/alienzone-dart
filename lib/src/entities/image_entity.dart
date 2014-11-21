part of alienzone;

const String GROUP_IMAGES      = "IMAGES";

class ImageEntity extends AbstractEntity {

  ImageEntity(entities, int x, int y, String key, double opacity)
  : super(entities) {

    Artemis.Entity image = level.artemis.createEntity();
    image
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new Opacity(opacity))
    ..addComponent(new Immovable(true))
    ..addToWorld();
    groupManager.add(image, GROUP_IMAGES);
  }

}