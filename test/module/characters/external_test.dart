import 'package:character_info/src/constants.dart';
import 'package:character_info/src/module/characters/external/external.dart';
import 'package:test/test.dart';

void main() {
  test("MarvelCharactersDatasource characters fetch", () async {
    var dt = MarvelCharactersDatasource(
      publicApiKey: kPublicApiKey,
      privateApiKey: kPrivateApiKey,
    );

    var result = await dt.getCharacters();

    expect(result.isRight(), true);
  });

  test("MarvelCharactersDatasource character comics fetch", () async {
    var dt = MarvelCharactersDatasource(
      publicApiKey: kPublicApiKey,
      privateApiKey: kPrivateApiKey,
    );

    // 3-D Man id = 1011334
    var result = await dt.getCharacterComics(1011334);

    expect(result.isRight(), true);
  });
}
