import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/infra/adapters/character_list_adapter.dart';
import 'package:character_info/src/module/characters/infra/adapters/comic_list_adapter.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICharacterDatasource {
  Future<Either<BaseException, ICharacterListAdapter>> getCharacters([
    int? offset,
  ]);

  Future<Either<BaseException, IComicListAdapter>> getCharacterComics(
    int id, [
    int? offset,
  ]);
}
