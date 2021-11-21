import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract class IGetCharactersUseCase {
  int get charactersLimit;

  Future<Either<BaseException, List<Character>>> getList([
    int? offset,
  ]);
}

class GetCharacters implements IGetCharactersUseCase {
  final ICharacterRepository repository;

  GetCharacters(this.repository);

  @override
  int get charactersLimit => repository.charactersLimit;

  @override
  Future<Either<BaseException, List<Character>>> getList([
    int? offset,
  ]) async =>
      await repository.getCharacters(offset);
}
