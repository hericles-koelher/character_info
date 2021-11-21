import 'package:character_info/src/constants.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/external/external.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';
import 'package:character_info/src/module/characters/presenter/presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

class CharacterInfo extends StatefulWidget {
  const CharacterInfo({Key? key}) : super(key: key);

  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  final KiwiContainer _kiwiContainer;

  _CharacterInfoState() : _kiwiContainer = KiwiContainer();

  @override
  void initState() {
    _kiwiContainer.registerInstance<ICharacterRepository>(
      CharacterRepository(
        MarvelCharactersDatasource(
          publicApiKey: kPublicApiKey,
          privateApiKey: kPrivateApiKey,
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Character Info",
      home: ListScreen(),
    );
  }
}
