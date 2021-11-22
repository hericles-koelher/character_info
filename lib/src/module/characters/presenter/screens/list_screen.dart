import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/presenter/presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kiwi/kiwi.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late final CharacterCubit _characterCubit;
  late final PagingController<int, Character> _pagingController;

  @override
  void initState() {
    super.initState();

    _characterCubit = CharacterCubit(
      GetCharacters(
        KiwiContainer().resolve<ICharacterRepository>(),
      ),
    );

    _pagingController = PagingController(firstPageKey: 0);

    _pagingController.addPageRequestListener((pageKey) {
      _characterCubit.fetchCharacters();
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
        title: const Text("Character List"),
        centerTitle: true,
      ),
      body: BlocConsumer<CharacterCubit, CharacterState>(
        bloc: _characterCubit,
        listener: (context, state) {
          if (state is! CharacterEnded) {
            _updatePagingController();
          }
        },
        builder: (context, state) {
          return Scrollbar(
            child: PagedGridView<int, Character>(
              pagingController: _pagingController,
              physics: const BouncingScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<Character>(
                itemBuilder: (context, character, index) => CharacterTile(
                  character: character,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(character: character),
                      ),
                    );
                  },
                ),
                firstPageErrorIndicatorBuilder: (context) => ErrorTile(
                  label: "Characters not found!\nTap to try again.",
                  icon: const Icon(Icons.refresh),
                  onTap: () {
                    _characterCubit.fetchCharacters();
                  },
                ),
                newPageErrorIndicatorBuilder: (context) => ErrorTile(
                  label: "Cannot find more characters!\nTap to try again.",
                  icon: const Icon(Icons.refresh),
                  onTap: () {
                    _characterCubit.fetchCharacters();
                  },
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              showNewPageProgressIndicatorAsGridChild: false,
              showNewPageErrorIndicatorAsGridChild: false,
              showNoMoreItemsIndicatorAsGridChild: false,
            ),
          );
        },
      ),
    );
  }

  Future<void> _updatePagingController() async {
    try {
      if (_characterCubit.state is CharacterFetchError) {
        // Só pra que o package saiba que existe um erro,
        // já que ele nao repassa esse valor a uma função de build.
        _pagingController.error = true;
      } else {
        final oldCharacters = _characterCubit.state.oldCharacters;
        final newCharacters = _characterCubit.state.newCharacters;

        final isLastPage =
            newCharacters.length < _characterCubit.state.charactersLimit;

        if (isLastPage) {
          _pagingController.appendLastPage(newCharacters);
        } else {
          _pagingController.appendPage(
            newCharacters,
            oldCharacters.length + newCharacters.length,
          );
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
