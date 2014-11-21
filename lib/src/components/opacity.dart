part of alienzone;

class Opacity extends Artemis.ComponentPoolable {
  double alpha;

  Opacity._();
  factory Opacity([alpha = 1.0]) {
    Opacity opacity = new Artemis.Poolable.of(Opacity, _constructor);
    opacity.alpha = alpha;
    return opacity;
  }
  static Opacity _constructor() => new Opacity._();
}

