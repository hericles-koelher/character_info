import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final int numberOfComics;
  final String name;
  final String description;
  final String imageUrl;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.numberOfComics,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        numberOfComics,
      ];
}
