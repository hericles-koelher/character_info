import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';
import 'package:fpdart/fpdart.dart';

class CharacterRepository implements ICharacterRepository {
  final ICharacterDatasource datasource;

  CharacterRepository(this.datasource);

  @override
  int get characterComicsLimit => datasource.characterComicsLimit;

  @override
  int get charactersLimit => datasource.charactersLimit;

  @override
  Future<Either<BaseException, List<Comic>>> getCharacterComics(int id,
      [int? offset]) async {
    Either<BaseException, IComicListAdapter> result =
        await datasource.getCharacterComics(id, offset);

    // Mapeia (se possivel) e retorna a lista de revistas,
    // ou só retorna o erro (elemento da esquerda).
    return result.map((r) => r.comics);
  }

  @override
  Future<Either<BaseException, List<Character>>> getCharacters(
      [int? offset]) async {
    Either<BaseException, ICharacterListAdapter> result =
        await datasource.getCharacters(offset);

    // Mapeia (se possivel) e retorna a lista de personagens,
    // ou só retorna o erro (elemento da esquerda).
    return result.map((r) => r.characters);
  }
}
