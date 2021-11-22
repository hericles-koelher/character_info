import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int? id;
  final int? numberOfComics;
  final String? name;
  final String? description;
  final String? portraitImageUrl;
  final String? landscapeImageUrl;

  const Character({
    this.id,
    this.numberOfComics,
    this.name,
    this.description,
    this.portraitImageUrl,
    this.landscapeImageUrl,
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
