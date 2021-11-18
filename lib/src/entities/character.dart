import 'package:character_info/src/entities/comic.dart';

class Character {
  final int id;
  final String name;
  final String? description;
  final Uri imageUrl;
  final List<Comic> comics;

  Character({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.comics,
  });
}
