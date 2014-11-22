part of alienzone;

class Action extends Artemis.ComponentPoolable {
  String name;

  Action._();
  factory Action(name) {
    Action action = new Artemis.Poolable.of(Action, _constructor);
    action.name = name;
    return action;
  }
  static Action _constructor() => new Action._();
}

