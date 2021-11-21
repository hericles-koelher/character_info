part of 'character_comic_cubit.dart';

abstract class CharacterComicState extends Equatable {
  final List<Comic> oldComics;
  final List<Comic> newComics;

  @override
  List<Object> get props => [oldComics, newComics];

  const CharacterComicState({
    required this.oldComics,
    required this.newComics,
  });
}

class CharacterComicInitial extends CharacterComicState {
  const CharacterComicInitial()
      : super(
          oldComics: const [],
          newComics: const [],
        );
}

class CharacterComicFetched extends CharacterComicState {
  const CharacterComicFetched({
    required List<Comic> oldComics,
    required List<Comic> newComics,
  }) : super(
          oldComics: oldComics,
          newComics: newComics,
        );
}

class CharacterComicEnded extends CharacterComicState {
  const CharacterComicEnded({required List<Comic> oldComics})
      : super(
          oldComics: oldComics,
          newComics: const [],
        );
}

class CharacterComicFetchError extends CharacterComicState {
  final BaseException exception;

  const CharacterComicFetchError({
    required List<Comic> oldComics,
    required this.exception,
  }) : super(
          oldComics: oldComics,
          newComics: const [],
        );

  @override
  List<Object> get props => [
        oldComics,
        exception,
      ];
}
