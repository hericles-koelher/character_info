import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final void Function()? onTap;

  const CharacterTile({
    Key? key,
    required this.character,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (character.imageUrl != null)
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: character.imageUrl!,
                ),
              ),
            if (character.name != null) Text(character.name!),
          ],
        ),
      ),
    );
  }
}
