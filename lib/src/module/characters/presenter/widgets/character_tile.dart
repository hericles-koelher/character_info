import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (character.portraitImageUrl != null)
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: character.portraitImageUrl!,
                    errorWidget: (_, __, ___) => const Image(
                      image: AssetImage("assets/images/image_error.jpg"),
                    ),
                  ),
                )
              else
                const Expanded(
                  child: Image(
                    image: AssetImage("assets/images/image_error.jpg"),
                  ),
                ),
              Text(
                character.name ?? "Name not found",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
