part of alienzone;

const String TAG_TIMER      = "TIMER";

class TimerEntity extends AbstractEntity {

  TimerEntity(entities, int x, int y, String action, String font, String fill)
  : super(entities) {

    Artemis.Entity button = level.artemis.createEntity();
    button
    ..addComponent(new Position(x,y))
    ..addComponent(new Time(0, 0, 0))
    ..addComponent(new Action(action))
    ..addComponent(new Text("00:00", font, fill))
    ..addToWorld();
    tagManager.register(button, TAG_TIMER);
  }

}