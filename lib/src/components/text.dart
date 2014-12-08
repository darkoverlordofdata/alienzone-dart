/**
 *--------------------------------------------------------------------+
 * text.dart
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
part of alienzone;

class Text extends Artemis.ComponentPoolable {

  String value;
  String font;
  String fill;

  Text._();
  factory Text(String value, String font, String fill) {
    Text text = new Artemis.Poolable.of(Text, _constructor);
    text.value = value;
    text.font = font;
    text.fill = fill;
    return text;
  }
  static Text _constructor() => new Text._();
}


