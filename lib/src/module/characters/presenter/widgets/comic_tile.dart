import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:flutter/material.dart';

class ComicTile extends StatelessWidget {
  final Comic comic;
  final void Function()? onTap;

  const ComicTile({
    Key? key,
    required this.comic,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (comic.imageUrl != null)
                Flexible(
                  child: CachedNetworkImage(
                    imageUrl: comic.imageUrl!,
                  ),
                ),
              if (comic.title != null)
                Text(
                  comic.title!,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
