import 'package:bloc/bloc.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'character_comic_state.dart';

class CharacterComicCubit extends Cubit<CharacterComicState> {
  final int characterId;
  final IGetCharacterComicsUseCase getCharacterComicsUseCase;

  CharacterComicCubit({
    required this.characterId,
    required this.getCharacterComicsUseCase,
  }) : super(const CharacterComicInitial());

  Future<void> fetchComics() async {
    if (state is CharacterComicInitial ||
        state is CharacterComicFetched ||
        state is CharacterComicFetchError) {
      Either<BaseException, List<Comic>?> result =
          await getCharacterComicsUseCase.getList(
        characterId,
        state.oldComics.length,
      );

      result.fold((exception) {
        emit(
          CharacterComicFetchError(
            oldComics: state.oldComics,
            exception: exception,
          ),
        );
      }, (newCharacterComicList) {
        if (newCharacterComicList != null) {
          emit(
            CharacterComicFetched(
              oldComics: [...state.oldComics, ...state.newComics],
              newComics: newCharacterComicList,
            ),
          );
        } else {
          emit(
            CharacterComicEnded(oldComics: state.oldComics),
          );
        }
      });
    }
  }
}
