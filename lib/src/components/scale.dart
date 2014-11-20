part of alienzone;

class Position extends Artemis.ComponentPoolable {
  num x, y;

  Position._();
  factory Position([num x = 0, num y = 0]) {
    Position position = new Artemis.Poolable.of(Position, _constructor);
    position.x = x;
    position.y = y;
    return position;
  }
  static Position _constructor() => new Position._();
}

