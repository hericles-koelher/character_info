import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract class IGetCharactersUseCase {
  Future<Either<BaseException, List<Character>?>> getList([
    int? offset,
  ]);
}

class GetCharacters implements IGetCharactersUseCase {
  final ICharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<BaseException, List<Character>?>> getList([
    int? offset,
  ]) async =>
      await repository.getCharacters(offset);
}
