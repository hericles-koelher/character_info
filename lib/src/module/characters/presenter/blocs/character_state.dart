part of 'character_cubit.dart';

abstract class CharacterState extends Equatable {
  final List<Character> characters;

  @override
  List<Object> get props => [characters];

  const CharacterState(this.characters);
}

class CharacterInitial extends CharacterState {
  const CharacterInitial() : super(const []);
}

class CharacterFetched extends CharacterState {
  const CharacterFetched(List<Character> characters) : super(characters);
}

class CharacterEnded extends CharacterState {
  const CharacterEnded(List<Character> characters) : super(characters);
}

class CharacterFetchError extends CharacterState {
  final BaseException exception;

  const CharacterFetchError({
    required List<Character> characters,
    required this.exception,
  }) : super(characters);

  @override
  List<Object> get props => [super.props, exception];
}
