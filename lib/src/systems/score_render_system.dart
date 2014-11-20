part of alienzone;


class ScoreRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;
  Text text;
  Count score;
  Phaser.Text scoreText;

  ScoreRenderSystem(this.level);

  void initialize() {
    print("ScoreRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Count> countMapper = new Artemis.ComponentMapper<Count>(Count, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    Artemis.TagManager tagManager = level.artemis.getManager(Artemis.TagManager);
    Artemis.Entity entity = tagManager.getEntity(TAG_SCORE);

    Position position = positionMapper.get(entity);
    text = textMapper.get(entity);
    score = countMapper.get(entity);
    var style = new Phaser.TextStyle(font: text.font, fill: text.fill);
    scoreText = level.game.add.text(position.x, position.y, "${text.value}: 0", style);
    level.context.registerScoreListener(this);
  }

  /**
   * Update the score
   */
  void update(int score) {
    scoreText.text = "${text.value} ${score}";
    scoreText.updateText();

  }

  void processSystem() {

  }
}
