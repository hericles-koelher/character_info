import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String? title;
  final String? imageUrl;

  const Comic({
    this.title,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        title,
        imageUrl,
      ];
}
