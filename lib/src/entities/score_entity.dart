/**
 *--------------------------------------------------------------------+
 * score_entity.dart
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