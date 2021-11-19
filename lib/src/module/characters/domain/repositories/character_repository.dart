import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICharacterRepository {
  Future<Either<BaseException, List<Character>>> getCharacters([
    int? offset,
  ]);

  Future<Either<BaseException, List<Comic>>> getCharacterComics(
    int id, [
    int? offset,
  ]);
}
