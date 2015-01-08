part of alienzone;



class ButtonRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;
  Context context;
  ButtonRenderSystem(this.level);


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
        level.state.start("credits", true, false, ["credits", 0]);
        break;

      case 'credits':
        js.context['Cocoon']['App']['WebView'].callMethod('on', ['load', new JsObject.jsify({
            'success': () {
              js.context['Cocoon']['App'].callMethod('showTheWebView', [0, 0, window.innerWidth * window.devicePixelRatio, window.innerHeight * window.devicePixelRatio]);
            },
            'error': () {
              window.alert("Unable to load the webview");
            }
        })]);
        js.context['Cocoon']['App'].callMethod('loadInTheWebView', ['webview/index.html']);

        break;
      case 'back':
        level.state.start(level.config.menu, true, false, [level.config.menu, 0]);
        break;
    }
  }


  void processSystem() {}
}
