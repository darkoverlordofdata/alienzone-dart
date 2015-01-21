part of alienzone;



class TimerControlSystem extends Artemis.VoidEntitySystem {

  CocoonServices cocoon;
  BaseLevel level;
  Context context;
  Time time;
  Action action;
  Text text;
  Position position;
  Phaser.Text timerText;

  bool done;
  num countdown;

  TimerControlSystem(this.level, this.cocoon);


  /**
   * Render Countdown Timer mm:ss
   */
  void initialize() {
    if (DEBUG) print("TimerControlSystem::initialize");
    context = level.context;
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Time> timeMapper = new Artemis.ComponentMapper<Time>(Time, level.artemis);
    Artemis.ComponentMapper<Action> actionMapper = new Artemis.ComponentMapper<Action>(Action, level.artemis);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    Artemis.TagManager tagManager = level.artemis.getManager(Artemis.TagManager);
    Artemis.Entity entity = tagManager.getEntity(TAG_TIMER);

    time = timeMapper.get(entity);
    action = actionMapper.get(entity);
    text = textMapper.get(entity);
    position = positionMapper.get(entity);
    var style = new Phaser.TextStyle(font: text.font, fill: text.fill);
    timerText = level.add.text(position.x, position.y, text.value, style);

    time.minutes = 0;
    time.seconds = 10;

    countdown = time.minutes * 60000 + time.seconds * 1000;
    done = false;
    displayTimer();
    level.context.reset.add(onReset);

  }


  /**
   * Clock tick
   */
  void processSystem() {

    countdown -= level.game.time.elapsed;
    if (countdown <= 0) {
      level.context.action.dispatch(action.name);
      countdown = time.minutes * 60000 + time.seconds * 1000;
    }
    displayTimer();
  }

  /**
   * Reset the countdown
   */
  void onReset() {
    countdown = time.minutes * 60000 + time.seconds * 1000;
    displayTimer();
  }

  /**
   * Display the timer
   */
  void displayTimer() {

    int minutes;
    int seconds;

    minutes = (countdown/1000).floor();
    seconds = minutes % 60;
    minutes = ((minutes - seconds)/60).floor();

    String t1 = minutes.toString();
    if (t1.length == 1) t1 = '0'+t1;

    String t2 = seconds.toString();
    if (t2.length == 1) t2 = '0'+t2;

    timerText.text = "$t1:$t2";
    timerText.updateText();


  }
}
