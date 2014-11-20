part of alienzone;

class Scale extends Artemis.ComponentPoolable {
  num x, y;

  Scale._();
  factory Scale([num x = 0, num y = 0]) {
    Scale scale = new Artemis.Poolable.of(Scale, _constructor);
    scale.x = x;
    scale.y = y;
    return scale;
  }
  static Scale _constructor() => new Scale._();
}

