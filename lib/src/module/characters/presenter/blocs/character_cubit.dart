import 'package:bloc/bloc.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final IGetCharactersUseCase getCharactersUseCase;

  CharacterCubit(this.getCharactersUseCase) : super(const CharacterInitial());

  Future<void> fetchCharacters() async {
    if (state is CharacterInitial ||
        state is CharacterFetched ||
        state is CharacterFetchError) {
      Either<BaseException, List<Character>> result = await getCharactersUseCase
          .getList(state.oldCharacters.length + state.newCharacters.length);

      result.fold((exception) {
        emit(
          CharacterFetchError(
            oldCharacters: state.oldCharacters,
            charactersLimit: getCharactersUseCase.charactersLimit,
            exception: exception,
          ),
        );
      }, (newCharacterList) {
        if (newCharacterList.isNotEmpty) {
          emit(
            CharacterFetched(
              oldCharacters: [...state.oldCharacters, ...state.newCharacters],
              charactersLimit: getCharactersUseCase.charactersLimit,
              newCharacters: newCharacterList,
            ),
          );
        } else {
          emit(
            CharacterEnded(
              oldCharacters: state.oldCharacters,
              charactersLimit: getCharactersUseCase.charactersLimit,
            ),
          );
        }
      });
    }
  }
}
