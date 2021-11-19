import 'package:character_info/src/module/characters/domain/models/comic.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';

class MarvelComicListAdapter implements IComicListAdapter {
  @override
  final List<Comic>? comics;

  MarvelComicListAdapter._([this.comics]);

  factory MarvelComicListAdapter.fromJson(Map<String, dynamic> json) {
    int count = int.parse(json["count"]);

    if (count == 0) {
      return MarvelComicListAdapter._();
    } else {
      List<Comic> comics = List.generate(
        count,
        (index) {
          Map<String, dynamic> comicJsonData = json["results"][index];

          String title = comicJsonData["title"];
          String imageUrl =
              "${comicJsonData["images"][0]["path"]}/portrait_xlarge.${comicJsonData["images"][0]["extension"]}";

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
