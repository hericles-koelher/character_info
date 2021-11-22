import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/presenter/blocs/character_comic_cubit.dart';
import 'package:character_info/src/module/characters/presenter/presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kiwi/kiwi.dart';

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
  late final PagingController<int, Comic> _pagingController;
  late final CharacterComicCubit _characterComicCubit;

  @override
  void initState() {
    super.initState();

    final kiwiContainer = KiwiContainer();

    _characterComicCubit = CharacterComicCubit(
      characterId: widget.character.id!,
      getCharacterComicsUseCase: GetCharacterComics(
        kiwiContainer.resolve<ICharacterRepository>(),
      ),
    );

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
    // Lista com informações do personagem.
    List<Widget> infoList = [
      if (widget.character.id != null)
        buildInfoField(
          label: "ID",
          info: widget.character.id.toString(),
          context: context,
        ),
      if (widget.character.name != null && widget.character.name!.isNotEmpty)
        buildInfoField(
          label: "Name",
          info: widget.character.name!,
          context: context,
        ),
      if (widget.character.description != null &&
          widget.character.description!.isNotEmpty)
        buildInfoField(
          label: "Description",
          info: widget.character.description!,
          context: context,
        ),
      if (widget.character.numberOfComics != null)
        buildInfoField(
          label: "Number of Comics",
          info: widget.character.numberOfComics.toString(),
          context: context,
        )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Details"),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 15,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: CachedNetworkImage(
                  // Se por acaso a url da imagem for null ou já for string vazia
                  // só vai dar erro e outro widget será exibido
                  imageUrl: widget.character.landscapeImageUrl ?? "",
                  errorWidget: (_, __, ___) => const Image(
                    image: AssetImage("assets/images/image_error.jpg"),
                  ),
                ),
              ),
            ),
            // Fiz isso pra poder colocar os Divider's somente onde for necessário
            ...infoList.expand((info) {
              if (infoList.last != info) {
                return [
                  info,
                  const Divider(),
                ];
              } else {
                return [info];
              }
            }),
            if (widget.character.id != null)
              // Pra resolver problema de 'unbounded height"...
              SizedBox(
                height: 250,
                child: BlocConsumer<CharacterComicCubit, CharacterComicState>(
                  bloc: _characterComicCubit,
                  listener: (context, state) {
                    if (state is! CharacterComicEnded) {
                      _updatePagingController();
                    }
                  },
                  builder: (context, state) {
                    return Scrollbar(
                      child: PagedListView<int, Comic>(
                        pagingController: _pagingController,
                        scrollDirection: Axis.horizontal,
                        builderDelegate: PagedChildBuilderDelegate<Comic>(
                          itemBuilder: (context, comic, index) => ComicTile(
                            comic: comic,
                            width: 200,
                            height: 250,
                          ),
                          firstPageErrorIndicatorBuilder: (context) =>
                              ErrorTile(
                            label: "Comics not found!\nTap to try again.",
                            icon: const Icon(Icons.refresh),
                            onTap: () {
                              _characterComicCubit.fetchComics();
                            },
                          ),
                          newPageErrorIndicatorBuilder: (context) => ErrorTile(
                            label:
                                "Cannot find more comics!\nTap to try again.",
                            icon: const Icon(Icons.refresh),
                            onTap: () {
                              _characterComicCubit.fetchComics();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoField({
    required String label,
    required String info,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label + ":",
            style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
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

  Future<void> _updatePagingController() async {
    try {
      if (_characterComicCubit.state is CharacterComicFetchError) {
        // Só pra que o package saiba que existe um erro,
        // já que ele nao repassa esse valor a uma função de build.
        _pagingController.error = true;
      } else {
        final oldComics = _characterComicCubit.state.oldComics;
        final newComics = _characterComicCubit.state.newComics;

        final isLastPage =
            newComics.length < _characterComicCubit.state.characterComicsLimit;

        if (isLastPage) {
          _pagingController.appendLastPage(newComics);
        } else {
          _pagingController.appendPage(
            newComics,
            oldComics.length + newComics.length,
          );
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
