import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

class ListScreen extends StatelessWidget {
  final CharacterCubit _characterCubit;

  ListScreen({Key? key})
      : _characterCubit = CharacterCubit(
          GetCharacters(
            KiwiContainer().resolve<ICharacterRepository>(),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
