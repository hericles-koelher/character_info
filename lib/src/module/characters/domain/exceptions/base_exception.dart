// Caso eu queira criar outra exceção...
abstract class BaseException implements Exception {
  String? message;

  BaseException(this.message);
}
