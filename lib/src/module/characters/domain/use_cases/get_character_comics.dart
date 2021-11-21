import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract class IGetCharacterComicsUseCase {
  int get characterComicsLimit;

  Future<Either<BaseException, List<Comic>?>> getList(
    int id, [
    int? offset,
  ]);
}

class GetCharacterComics implements IGetCharacterComicsUseCase {
  final ICharacterRepository repository;

  GetCharacterComics(this.repository);

  @override
  int get characterComicsLimit => repository.characterComicsLimit;

  @override
  Future<Either<BaseException, List<Comic>?>> getList(
    int id, [
    int? offset,
  ]) async =>
      await repository.getCharacterComics(id, offset);
}
