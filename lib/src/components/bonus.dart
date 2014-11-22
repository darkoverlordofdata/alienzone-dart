part of alienzone;

class Bonus extends Artemis.ComponentPoolable {
  String src;

  Bonus._();
  factory Bonus(String src) {
    Bonus bonus = new Artemis.Poolable.of(Bonus, _constructor);
    bonus.src = src;
    return bonus;
  }
  static Bonus _constructor() => new Bonus._();
}

