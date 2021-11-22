import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final int numberOfComics;
  final String name;
  final String description;
  final String portraitImageUrl;
  final String landscapeImageUrl;

  const Character({
    required this.id,
    required this.numberOfComics,
    required this.name,
    required this.description,
    required this.portraitImageUrl,
    required this.landscapeImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        portraitImageUrl,
        numberOfComics,
      ];
}
