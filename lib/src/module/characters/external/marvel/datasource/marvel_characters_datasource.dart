import 'dart:convert';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/external/external.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class MarvelCharactersDatasource implements ICharacterDatasource {
  static const Utf8Encoder _utf8encoder = Utf8Encoder();
  static final Dio _dio = Dio();

  final int _charactersLimit;
  final int _characterComicsLimit;
  final String publicApiKey;
  final String privateApiKey;

  MarvelCharactersDatasource({
    required this.publicApiKey,
    required this.privateApiKey,
    int charactersLimit = 20,
    int characterComicsLimit = 20,
  })  : assert(charactersLimit >= 1 && charactersLimit <= 100),
        assert(characterComicsLimit >= 1 && characterComicsLimit <= 100),
        _charactersLimit = charactersLimit,
        _characterComicsLimit = characterComicsLimit;

  @override
  int get charactersLimit => _charactersLimit;

  @override
  int get characterComicsLimit => _characterComicsLimit;

  String get _charactersBaseUrl =>
      "http://gateway.marvel.com/v1/public/characters";

  String _comicsBaseUrl(int id) => "$_charactersBaseUrl/$id/comics";

  @override
  Future<Either<FetchDataException, MarvelComicListAdapter>> getCharacterComics(
      int id,
      [int? offset]) async {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    List<int> byteList =
        _utf8encoder.convert("$currentTimestamp$privateApiKey$publicApiKey");

    try {
      String hash = md5.convert(byteList).toString();

      Response response = await _dio.get(_comicsBaseUrl(id), queryParameters: {
        "ts": currentTimestamp,
        "apikey": publicApiKey,
        "hash": hash,
        "offset": offset,
        "limit": characterComicsLimit,
      });

      return Right(
        MarvelComicListAdapter.fromJson(response.data),
      );
    } on DioError catch (e) {
      return Left(
        FetchDataException(
          message: e.message,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FetchDataException, MarvelCharacterListAdapter>> getCharacters([
    int? offset,
  ]) async {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    List<int> byteList =
        _utf8encoder.convert("$currentTimestamp$privateApiKey$publicApiKey");

    try {
      String hash = md5.convert(byteList).toString();

      Response response = await _dio.get(_charactersBaseUrl, queryParameters: {
        "ts": currentTimestamp,
        "apikey": publicApiKey,
        "hash": hash,
        "offset": offset,
        "limit": charactersLimit,
      });

      return Right(
        MarvelCharacterListAdapter.fromJson(response.data),
      );
    } on DioError catch (e) {
      return Left(
        FetchDataException(
          message: e.message,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace.toString(),
        ),
      );
    }
  }
}
