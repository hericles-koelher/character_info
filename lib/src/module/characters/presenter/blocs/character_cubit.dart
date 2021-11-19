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
      Either<BaseException, List<Character>> result =
          await getCharactersUseCase.getList(state.characters.length);

      result.fold((l) {
        if (l is WithoutDataException && l.statusCode == 200) {
          emit(
            CharacterEnded(state.characters),
          );
        } else {
          emit(
            CharacterFetchError(
              characters: state.characters,
              exception: l,
            ),
          );
        }
      }, (r) {
        emit(
          CharacterFetched([...state.characters, ...r]),
        );
      });
    }
  }
}
