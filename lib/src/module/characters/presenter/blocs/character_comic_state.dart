part of 'character_comic_cubit.dart';

abstract class CharacterComicState extends Equatable {
  final List<Comic> oldComics;
  final List<Comic> newComics;
  final int characterComicsLimit;

  @override
  List<Object> get props => [
        oldComics,
        newComics,
        characterComicsLimit,
      ];

  const CharacterComicState({
    required this.oldComics,
    required this.newComics,
    required this.characterComicsLimit,
  });
}

class CharacterComicInitial extends CharacterComicState {
  const CharacterComicInitial()
      : super(
          oldComics: const [],
          newComics: const [],
          characterComicsLimit: 0,
        );
}

class CharacterComicFetched extends CharacterComicState {
  const CharacterComicFetched({
    required List<Comic> oldComics,
    required List<Comic> newComics,
    required int characterComicsLimit,
  }) : super(
          oldComics: oldComics,
          newComics: newComics,
          characterComicsLimit: characterComicsLimit,
        );
}

class CharacterComicEnded extends CharacterComicState {
  const CharacterComicEnded({
    required List<Comic> oldComics,
    required int characterComicsLimit,
  }) : super(
          oldComics: oldComics,
          newComics: const [],
          characterComicsLimit: characterComicsLimit,
        );
}

class CharacterComicFetchError extends CharacterComicState {
  final BaseException exception;

  const CharacterComicFetchError({
    required List<Comic> oldComics,
    required int characterComicsLimit,
    required this.exception,
  }) : super(
          oldComics: oldComics,
          newComics: const [],
          characterComicsLimit: characterComicsLimit,
        );

  @override
  List<Object> get props => [
        super.props,
        exception,
      ];
}
