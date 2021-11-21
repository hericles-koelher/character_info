import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int? id;
  final int? numberOfComics;
  final String? name;
  final String? description;
  final String? imageUrl;

  const Character({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.numberOfComics,
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
