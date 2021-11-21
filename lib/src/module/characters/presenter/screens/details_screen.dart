import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/presenter/blocs/character_comic_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
// Não deveria fazer isso, mas infelizmente o mantenedor do pacote não
// exportou esse arquivo.
// Issue reportada. Link em https://github.com/vanlooverenkoen/kiwi/issues/75
import 'package:kiwi/src/model/exception/not_registered_error.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;
  late final CharacterComicCubit _characterComicCubit;

  DetailsScreen({Key? key, required this.character}) : super(key: key) {
    final kiwiContainer = KiwiContainer();

    try {
      _characterComicCubit = kiwiContainer.resolve(character.id!.toString());
    } on NotRegisteredKiwiError {
      _characterComicCubit = CharacterComicCubit(
        characterId: character.id!,
        getCharacterComicsUseCase: GetCharacterComics(
          kiwiContainer.resolve<ICharacterRepository>(),
        ),
      );

      kiwiContainer.registerInstance(character.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 15,
        ),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      ),
    );
  }
}
