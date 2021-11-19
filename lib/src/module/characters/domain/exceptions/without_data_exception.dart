import 'package:character_info/src/module/characters/domain/domain.dart';

class WithoutDataException extends BaseException {
  @override
  final String? message;

  final String? stackTrace;
  final int? statusCode;

  WithoutDataException({
    this.message,
    this.stackTrace,
    this.statusCode,
  });

  @override
  String toString() {
    String result = "";

    if (statusCode != null) result += "Status Code: $statusCode\n";
    if (message != null) result += "Message: $message\n";
    if (stackTrace != null) result += "Stack Trace: $stackTrace\n";

    return result;
  }
}
