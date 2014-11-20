part of alienzone;

const String TAG_SCORE        = "SCORE";

class ScoreEntity extends AbstractEntity {

  ScoreEntity(entities, int x, int y, String text, String font, String fill)
  : super(entities) {

    Artemis.Entity score = level.artemis.createEntity();
    score
    ..addComponent(new Position(x, y))
    ..addComponent(new Text(text, font, fill))
    ..addComponent(new Count(0))
    ..addToWorld();
    tagManager.register(score, TAG_SCORE);
  }

}