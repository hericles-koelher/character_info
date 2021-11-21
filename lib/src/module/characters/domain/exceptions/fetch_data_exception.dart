import 'package:character_info/src/module/characters/domain/domain.dart';

// Usada para exceções mais gerais, como por exemplo falha de comunicação com uma API.
class FetchDataException extends BaseException {
  final String? stackTrace;
  final int? statusCode;

  FetchDataException({
    String? message,
    this.stackTrace,
    this.statusCode,
  }) : super(message);

  @override
  String toString() {
    String result = "Exception occurred when fetching data:\n";

    if (statusCode != null) result += "\tStatus Code: $statusCode\n";
    if (message != null) result += "\tMessage: $message\n";
    if (stackTrace != null) result += "\tStack Trace: $stackTrace\n";

    return result;
  }
}
