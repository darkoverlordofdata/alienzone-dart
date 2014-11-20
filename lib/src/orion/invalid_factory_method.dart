part of alienzone;


class InvalidFactoryMethodException extends Exception {

  InvalidFactoryMethodException(name)
  :super("Invalid system factory method: $name")

  }
}