part of alienzone;

class State extends Artemis.ComponentPoolable {
  int name;

  State._();
  factory State(name) {
    State state = new Artemis.Poolable.of(State, _constructor);
    state.name = name;
    return state;
  }
  static State _constructor() => new State._();
}

