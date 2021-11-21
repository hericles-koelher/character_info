import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';

class MarvelComicListAdapter implements IComicListAdapter {
  @override
  final List<Comic>? comics;

  MarvelComicListAdapter._([this.comics]);

  factory MarvelComicListAdapter.fromJson(Map<String, dynamic> json) {
    int count = json["count"];

    if (count == 0) {
      return MarvelComicListAdapter._();
    } else {
      List<Comic> comics = List.generate(
        count,
        (index) {
          Map<String, dynamic> comicJsonData = json["results"][index];

          String? title = comicJsonData.containsKey("title")
              ? comicJsonData["title"]
              : null;

          String? imageUrl = comicJsonData.containsKey("images") &&
                  (comicJsonData["images"] as List).isNotEmpty
              ? "${comicJsonData["images"][0]["path"]}/portrait_xlarge.${comicJsonData["images"][0]["extension"]}"
              : null;

          return Comic(
            title: title,
            imageUrl: imageUrl,
          );
        },
      );

      return MarvelComicListAdapter._(comics);
    }
  }
}
