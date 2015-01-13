part of alienzone;



class ButtonRenderSystem extends Artemis.VoidEntitySystem {

  CocoonServices cocoon;
  BaseLevel level;
  Context context;
  ButtonRenderSystem(this.level, this.cocoon);


  void initialize() {
    if (DEBUG) print("ButtonRenderSystem::initialize");
    context = level.context;
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Action> actionMapper = new Artemis.ComponentMapper<Action>(Action, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    groupManager.getEntities(GROUP_BUTTONS).forEach((entity) {

      Sprite sprite = spriteMapper.get(entity);
      Action action = actionMapper.get(entity);
      Text text = textMapper.get(entity);

      Phaser.Button button = level.add.button(sprite.x, sprite.y, sprite.key,
          (source, input, flag) => level.context.action.dispatch(action.name));

      if (text.value.length > 0) {
        Phaser.TextStyle style = new Phaser.TextStyle(font: text.font, fill: text.fill);
        Phaser.Text label = new Phaser.Text(level.game, 0, 0, text.value, style);
        button.addChild(label);
        label.setText(text.value);
        label.x = ((button.width - label.width)/2).floor();
        label.y = ((button.height - label.height)/2).floor();
      }
      //context.button[sprite.key] = button;
      level.context.action.add(onClick);
    });
  }

  onClick(String name) {
    switch (name) {
      case 'play':
        level.state.start("game", true, false, ["game", 0]);
        break;
      case 'achievements':
        cocoon.showAchievements();
        break;
      case 'leaderboard':
        cocoon.showLeaderboard();
        break;
      case 'credits':
//        try {
//          JsObject leaderboard = js.context.callMethod(r'$', ['#leaderboard']);
//          leaderboard.callMethod('modal', ['show']);
//        } catch(e) {
//          window.console.log(e);
//        }
        level.state.start("credits", true, false, ["credits", 0]);
        break;
      case 'back':
        level.state.start(level.config.menu, true, false, [level.config.menu, 0]);
        break;
    }
  }


  void processSystem() {}
}
