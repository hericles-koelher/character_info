import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/external/external.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';
import 'package:character_info/src/module/characters/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter/services.dart' show rootBundle;

class CharacterInfo extends StatefulWidget {
  const CharacterInfo({Key? key}) : super(key: key);

  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  final KiwiContainer _kiwiContainer;

  _CharacterInfoState() : _kiwiContainer = KiwiContainer();

  @override
  Future<void> initState() async {
    String publicApiKey = await rootBundle.loadString("publicApiKey");
    String privateApiKey = await rootBundle.loadString("privateApiKey");

    ICharacterDatasource datasource = MarvelCharactersDatasource(
      publicApiKey: publicApiKey,
      privateApiKey: privateApiKey,
    );

    _kiwiContainer.registerInstance<ICharacterRepository>(
      CharacterRepository(datasource),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen();
  }
}
