import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:flutter/material.dart';

class ComicTile extends StatelessWidget {
  final Comic comic;
  final double? height;
  final double? width;
  final void Function()? onTap;

  const ComicTile({
    Key? key,
    required this.comic,
    this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (comic.imageUrl != null)
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: comic.imageUrl!,
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  comic.title ?? "Title not found",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
