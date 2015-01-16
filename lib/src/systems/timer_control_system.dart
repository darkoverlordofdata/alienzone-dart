part of alienzone;



class TimerControlSystem extends Artemis.VoidEntitySystem {

  CocoonServices cocoon;
  BaseLevel level;
  Context context;
  TimerControlSystem(this.level, this.cocoon);


  void initialize() {
    if (DEBUG) print("TimerControlSystem::initialize");
    context = level.context;
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Time> timeMapper = new Artemis.ComponentMapper<Time>(Time, level.artemis);
    Artemis.ComponentMapper<Action> actionMapper = new Artemis.ComponentMapper<Action>(Action, level.artemis);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    groupManager.getEntities(GROUP_TIMERS).forEach((entity) {

      Time time = timeMapper.get(entity);
      Action action = actionMapper.get(entity);
      Text text = textMapper.get(entity);
      Position position = positionMapper.get(entity);

    });
  }



  void processSystem() {}
}
