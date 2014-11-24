part of alienzone;
/**
 * Expose Phaser objects to Artemis
 */

class Context {

  int _score = 0;
  int _legend = 0;

  BaseLevel level;
  Phaser.Signal scored = null;
  Phaser.Signal pegged = null;


  Context(this.level) {
    scored = new Phaser.Signal();
    pegged = new Phaser.Signal();
  }

  /**
   * Game Score
   */
  int get score => _score;

//  set score(int value) {
//    _score = value;
//    scored.dispatch(_score);
//
//  }

  void updateScore(int points) {
    _score += points;
    scored.dispatch(points);
  }

  int get legend => _legend;

  set legend(int value) {
    _legend = value;
    pegged.dispatch(_legend);

  }


}

