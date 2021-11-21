import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/presenter/presenter.dart';
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
  final CharacterCubit _characterCubit;
  final PagingController<int, Character> _pagingController;
  bool flag = false;

  _ListScreenState()
      : _characterCubit = CharacterCubit(
          GetCharacters(
            KiwiContainer().resolve<ICharacterRepository>(),
          ),
        ),
        _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

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
    return BlocConsumer<CharacterCubit, CharacterState>(
      bloc: _characterCubit,
      listener: (context, state) {
        if (state is! CharacterEnded) {
          _updatePagingController();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: PagedGridView<int, Character>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Character>(
              itemBuilder: (context, character, index) =>
                  CharacterTile(character: character),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          ),
        );
      },
    );
  }

  Future<void> _updatePagingController() async {
    try {
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
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
