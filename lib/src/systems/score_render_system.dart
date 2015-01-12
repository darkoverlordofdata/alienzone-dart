/**
 *--------------------------------------------------------------------+
 * score_render_system.dart
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
part of alienzone;


class ScoreRenderSystem extends Artemis.VoidEntitySystem {

  static const SFX_COUNT = 19;

  BaseLevel level;
  CocoonServices cocoon;
  Position position;
  Text text;
  Count score;
  List<Phaser.Sound> bonus = [];
  Phaser.Text scoreText;

  /**
   * Color and position cycles for points popup
   */
  int counter = 0;
  List colors = ["#ff0", "#f0f", "#0ff"];
  List cols = [30, 105, 180];
  List rows = [250, 150, 250];


  ScoreRenderSystem(this.level, this.cocoon);

  void initialize() {
    if (DEBUG) print("ScoreRenderSystem::initialize");

    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Count> countMapper = new Artemis.ComponentMapper<Count>(Count, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    Artemis.TagManager tagManager = level.artemis.getManager(Artemis.TagManager);
    Artemis.Entity entity = tagManager.getEntity(TAG_SCORE);

    position = positionMapper.get(entity);
    text = textMapper.get(entity);
    score = countMapper.get(entity);
    var style = new Phaser.TextStyle(font: text.font, fill: text.fill);
    scoreText = level.add.text(position.x, position.y, "${text.value}: 0", style);

    for (int i=1; i<=SFX_COUNT+1; i++) {
      bonus.add(level.add.audio("bonus$i"));
    }

    level.context.scored.add(updateScore);
    level.game.sound.volume = level.context.volume;

  }

  /**
   * Signaled event Update Score
   *
   * Receives the number of points just added to the score
   *
   * return none
   */
  updateScore(int points) {

    scoreText.text = "${text.value}: ${level.context.score}";
    scoreText.updateText();

    if (points == 0) return;

    // make a popup with the points
    var scoreStyle = new Phaser.TextStyle(font: "bold 120px opendyslexic",fill: colors[counter], align: "center");
    Phaser.Text popup = level.add.text(cols[counter], rows[counter], "$points", scoreStyle);
    counter += 1;
    if (counter > 2) counter = 0;

    bonus[points % SFX_COUNT].play();
    const int speed = 1000;
    level.add.tween(popup)
    .to({'alpha': 1}, (speed*0.75).toInt(), Phaser.Easing.Linear.None, true)
    .to({'alpha': 0}, (speed*0.25).toInt(), Phaser.Easing.Linear.None, true);

    new async.Timer(const Duration(milliseconds: speed),
        () => level.world.remove(popup));

  }

  void processSystem() {

  }
}
