import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';

class MarvelComicListAdapter implements IComicListAdapter {
  @override
  final List<Comic> comics;

  MarvelComicListAdapter._(this.comics);

  factory MarvelComicListAdapter.fromJson(Map<String, dynamic> json) {
    int count = json["data"]["count"];

    List<Comic> comics = List.generate(
      count,
      (index) {
        Map<String, dynamic> comicJsonData = json["data"]["results"][index];

        String title =
            comicJsonData.containsKey("title") ? comicJsonData["title"] : "";

        String imageUrl = comicJsonData.containsKey("images") &&
                (comicJsonData["images"] as List).isNotEmpty
            ? "${comicJsonData["images"][0]["path"]}/portrait_fantastic.${comicJsonData["images"][0]["extension"]}"
            : "";

        return Comic(
          title: title,
          imageUrl: imageUrl,
        );
      },
    );

    return MarvelComicListAdapter._(comics);
  }
}
