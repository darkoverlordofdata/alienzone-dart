part of alienzone;

const String GROUP_LEGEND      = "LEGEND";

class LegendEntity extends AbstractEntity {

  LegendEntity(entities, int x, int y, String key, int frame, double opacity)
  : super(entities) {

    Artemis.Entity legend = level.artemis.createEntity();
    legend
    ..addComponent(new Sprite(x, y, key, frame))
    ..addComponent(new Opacity(opacity))
    ..addComponent(new Immovable(true))
    ..addToWorld();
//    groupManager.add(legend, GROUP_SPRITES);
    groupManager.add(legend, GROUP_LEGEND);
  }

}