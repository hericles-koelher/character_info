part of 'character_cubit.dart';

abstract class CharacterState extends Equatable {
  final List<Character> oldCharacters;
  final List<Character> newCharacters;
  final int charactersLimit;

  @override
  List<Object> get props => [
        oldCharacters,
        newCharacters,
        charactersLimit,
      ];

  const CharacterState({
    required this.oldCharacters,
    required this.newCharacters,
    required this.charactersLimit,
  });
}

class CharacterInitial extends CharacterState {
  const CharacterInitial()
      : super(
          oldCharacters: const [],
          newCharacters: const [],
          charactersLimit: 0,
        );
}

class CharacterFetched extends CharacterState {
  const CharacterFetched({
    required List<Character> oldCharacters,
    required List<Character> newCharacters,
    required int charactersLimit,
  }) : super(
          oldCharacters: oldCharacters,
          newCharacters: newCharacters,
          charactersLimit: charactersLimit,
        );
}

class CharacterEnded extends CharacterState {
  const CharacterEnded({
    required List<Character> oldCharacters,
    required int charactersLimit,
  }) : super(
          oldCharacters: oldCharacters,
          newCharacters: const [],
          charactersLimit: charactersLimit,
        );
}

class CharacterFetchError extends CharacterState {
  final BaseException exception;

  const CharacterFetchError({
    required List<Character> oldCharacters,
    required int charactersLimit,
    required this.exception,
  }) : super(
          oldCharacters: oldCharacters,
          newCharacters: const [],
          charactersLimit: charactersLimit,
        );

  @override
  List<Object> get props => [super.props, exception];
}
