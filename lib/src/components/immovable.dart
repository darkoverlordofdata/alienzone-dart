part of alienzone;

class Immovable extends Artemis.ComponentPoolable {
  bool value;

  Immovable._();
  factory Immovable([value = true]) {
    Immovable immovable = new Artemis.Poolable.of(Immovable, _constructor);
    immovable.value = value;
    return immovable;
  }
  static Immovable _constructor() => new Immovable._();
}

