import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/presenter/blocs/character_comic_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kiwi/kiwi.dart';
// Não deveria fazer isso, mas infelizmente o mantenedor do pacote não
// exportou esse arquivo.
// Issue reportada. Link em https://github.com/vanlooverenkoen/kiwi/issues/75
import 'package:kiwi/src/model/exception/not_registered_error.dart';

class DetailsScreen extends StatefulWidget {
  final Character character;

  const DetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final PagingController<int, Character> _pagingController;
  late final CharacterComicCubit _characterComicCubit;

  @override
  void initState() {
    super.initState();

    final kiwiContainer = KiwiContainer();

    try {
      _characterComicCubit =
          kiwiContainer.resolve(widget.character.id!.toString());
    } on NotRegisteredKiwiError {
      _characterComicCubit = CharacterComicCubit(
        characterId: widget.character.id!,
        getCharacterComicsUseCase: GetCharacterComics(
          kiwiContainer.resolve<ICharacterRepository>(),
        ),
      );

      kiwiContainer.registerInstance(
        _characterComicCubit,
        name: widget.character.id.toString(),
      );
    }

    _pagingController = PagingController(firstPageKey: 0);

    _pagingController.addPageRequestListener((pageKey) {
      _characterComicCubit.fetchComics();
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
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
          children: [
            if (widget.character.imageUrl != null &&
                widget.character.imageUrl!.isNotEmpty)
              CachedNetworkImage(imageUrl: widget.character.imageUrl!),
            if (widget.character.id != null)
              infoField(
                label: "ID",
                info: widget.character.id.toString(),
                context: context,
              ),
            if (widget.character.name != null &&
                widget.character.name!.isNotEmpty)
              infoField(
                label: "Name",
                info: widget.character.name!,
                context: context,
              ),
            if (widget.character.description != null &&
                widget.character.description!.isNotEmpty)
              infoField(
                label: "Description",
                info: widget.character.description!,
                context: context,
              ),
            if (widget.character.numberOfComics != null)
              infoField(
                label: "Number of Comics",
                info: widget.character.numberOfComics.toString(),
                context: context,
              ),
          ],
        ),
      ),
    );
  }

  Widget infoField({
    required String label,
    required String info,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label + ":",
            style: textTheme.subtitle2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            info,
            style: textTheme.bodyText2,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
