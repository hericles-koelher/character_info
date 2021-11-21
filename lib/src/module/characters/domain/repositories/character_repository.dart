import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICharacterRepository {
  int get charactersLimit;
  int get characterComicsLimit;

  Future<Either<BaseException, List<Character>?>> getCharacters([
    int? offset,
  ]);

  Future<Either<BaseException, List<Comic>?>> getCharacterComics(
    int id, [
    int? offset,
  ]);
}
