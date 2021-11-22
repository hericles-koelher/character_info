import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';

class MarvelCharacterListAdapter implements ICharacterListAdapter {
  @override
  final List<Character> characters;

  MarvelCharacterListAdapter._(this.characters);

  factory MarvelCharacterListAdapter.fromJson(Map<String, dynamic> json) {
    int count = json["data"]["count"];

    List<Character> characters = List.generate(
      count,
      (index) {
        Map<String, dynamic> characterJsonData = json["data"]["results"][index];

        int id =
            characterJsonData.containsKey("id") ? characterJsonData["id"] : 0;

        String name = characterJsonData.containsKey("name")
            ? characterJsonData["name"]
            : "";

        String description = characterJsonData.containsKey("description")
            ? characterJsonData["description"]
            : "";

        String portraitImageUrl;
        String landscapeImageUrl;

        if (characterJsonData.containsKey("thumbnail")) {
          portraitImageUrl =
              "${characterJsonData["thumbnail"]["path"]}/portrait_fantastic.${characterJsonData["thumbnail"]["extension"]}";
          landscapeImageUrl =
              "${characterJsonData["thumbnail"]["path"]}/landscape_amazing.${characterJsonData["thumbnail"]["extension"]}";
        } else {
          portraitImageUrl = "";
          landscapeImageUrl = "";
        }

        int numberOfComics = characterJsonData.containsKey("comics")
            ? characterJsonData["comics"]["available"]
            : 0;

        return Character(
          id: id,
          name: name,
          description: description,
          portraitImageUrl: portraitImageUrl,
          landscapeImageUrl: landscapeImageUrl,
          numberOfComics: numberOfComics,
        );
      },
    );

    return MarvelCharacterListAdapter._(characters);
  }
}
