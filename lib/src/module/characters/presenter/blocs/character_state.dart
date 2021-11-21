part of 'character_cubit.dart';

abstract class CharacterState extends Equatable {
  final List<Character> oldCharacters;
  final List<Character> newCharacters;

  @override
  List<Object> get props => [oldCharacters, newCharacters];

  const CharacterState({
    required this.oldCharacters,
    required this.newCharacters,
  });
}

class CharacterInitial extends CharacterState {
  const CharacterInitial()
      : super(
          oldCharacters: const [],
          newCharacters: const [],
        );
}

class CharacterFetched extends CharacterState {
  const CharacterFetched({
    required List<Character> oldCharacters,
    required List<Character> newCharacters,
  }) : super(
          oldCharacters: oldCharacters,
          newCharacters: newCharacters,
        );
}

class CharacterEnded extends CharacterState {
  const CharacterEnded({required List<Character> oldCharacters})
      : super(
          oldCharacters: oldCharacters,
          newCharacters: const [],
        );
}

class CharacterFetchError extends CharacterState {
  final BaseException exception;

  const CharacterFetchError({
    required List<Character> oldCharacters,
    required this.exception,
  }) : super(
          oldCharacters: oldCharacters,
          newCharacters: const [],
        );

  @override
  List<Object> get props => [super.props, exception];
}
