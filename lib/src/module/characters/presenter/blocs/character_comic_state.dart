part of 'character_comic_cubit.dart';

abstract class CharacterComicState extends Equatable {
  final List<Comic> comics;

  @override
  List<Object> get props => [comics];

  const CharacterComicState(this.comics);
}

class CharacterComicInitial extends CharacterComicState {
  const CharacterComicInitial() : super(const []);
}

class CharacterComicFetched extends CharacterComicState {
  const CharacterComicFetched(List<Comic> comics) : super(comics);
}

class CharacterComicEnded extends CharacterComicState {
  const CharacterComicEnded(List<Comic> comics) : super(comics);
}

class CharacterComicFetchError extends CharacterComicState {
  final BaseException exception;

  const CharacterComicFetchError({
    required List<Comic> comics,
    required this.exception,
  }) : super(comics);

  @override
  List<Object> get props => [
        comics,
        exception,
      ];
}
