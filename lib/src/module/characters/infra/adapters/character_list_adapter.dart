import 'package:character_info/src/module/characters/domain/models/character.dart';

abstract class ICharacterListAdapter {
  List<Character>? get characters;
}
