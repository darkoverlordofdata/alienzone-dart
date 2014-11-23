part of alienzone;

class Number extends Artemis.ComponentPoolable {
  int value;

  Number._();
  factory Number([value = true]) {
    Number number = new Artemis.Poolable.of(Number, _constructor);
    number.value = value;
    return number;
  }
  static Number _constructor() => new Number._();
}

