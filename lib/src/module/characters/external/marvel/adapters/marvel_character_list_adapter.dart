import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';

class MarvelCharacterListAdapter implements ICharacterListAdapter {
  @override
  final List<Character>? characters;

  MarvelCharacterListAdapter._([this.characters]);

  factory MarvelCharacterListAdapter.fromJson(Map<String, dynamic> json) {
    int count = json["count"];

    if (count == 0) {
      return MarvelCharacterListAdapter._();
    } else {
      List<Character> characters = List.generate(
        count,
        (index) {
          Map<String, dynamic> characterJsonData = json["results"][index];

          int? id = characterJsonData.containsKey("id")
              ? characterJsonData["id"]
              : null;

          String? name = characterJsonData.containsKey("name")
              ? characterJsonData["name"]
              : null;

          String? description = characterJsonData.containsKey("description")
              ? characterJsonData["description"]
              : null;

          String? imageUrl = characterJsonData.containsKey("thumbnail")
              ? "${characterJsonData["thumbnail"]["path"]}/portrait_xlarge.${characterJsonData["thumbnail"]["extension"]}"
              : null;

          int? numberOfComics = characterJsonData.containsKey("comics")
              ? characterJsonData["comics"]["available"]
              : null;

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
