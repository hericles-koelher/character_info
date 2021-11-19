import 'package:character_info/src/module/characters/domain/models/character.dart';
import 'package:character_info/src/module/characters/infra/adapters/character_list_adapter.dart';

class MarvelCharacterListAdapter implements ICharacterListAdapter {
  @override
  final List<Character>? characters;

  MarvelCharacterListAdapter._([this.characters]);

  factory MarvelCharacterListAdapter.fromJson(Map<String, dynamic> json) {
    int count = int.parse(json["count"]);

    if (count == 0) {
      return MarvelCharacterListAdapter._();
    } else {
      List<Character> characters = List.generate(
        count,
        (index) {
          Map<String, dynamic> characterJsonData = json["results"][index];

          int id = int.parse(characterJsonData["id"]);
          String name = characterJsonData["name"];
          String description = characterJsonData["description"];
          String imageUrl =
              "${characterJsonData["thumbnail"]["path"]}/portrait_xlarge.${characterJsonData["thumbnail"]["extension"]}";

          int numberOfComics =
              int.parse(characterJsonData["comics"]["available"]);

          return Character(
            id: id,
            name: name,
            description: description,
            imageUrl: imageUrl,
            numberOfComics: numberOfComics,
          );
        },
      );

      return MarvelCharacterListAdapter._(characters);
    }
  }
}
