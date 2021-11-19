import 'dart:convert';
import 'package:character_info/src/module/characters/domain/domain.dart';
import 'package:character_info/src/module/characters/external/external.dart';
import 'package:character_info/src/module/characters/infra/infra.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class MarvelCharactersDatasource implements ICharacterDatasource {
  static final Dio _dio = Dio();
  static const Utf8Encoder _utf8encoder = Utf8Encoder();
  static const String imgSize = "portrait_xlarge";
  final String publicApiKey;
  final String privateApiKey;

  MarvelCharactersDatasource({
    required this.publicApiKey,
    required this.privateApiKey,
  });

  String get _charactersBaseUrl =>
      "https://gateway.marvel.com:443/v1/public/characters";

  String _comicsBaseUrl(int id) => "$_charactersBaseUrl/$id/comics";

  @override
  Future<Either<WithoutDataException, MarvelComicListAdapter>>
      getCharacterComics(int id, [int? offset]) async {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    List<int> byteList =
        _utf8encoder.convert("$currentTimestamp$privateApiKey$publicApiKey");

    try {
      String hash = md5.convert(byteList).toString();

      Response response = await _dio.get(_comicsBaseUrl(id), queryParameters: {
        "apiKey": publicApiKey,
        "hash": hash,
        "ts": currentTimestamp,
      });

      Map<String, dynamic> jsonData = response.data["data"];

      return Right(
        MarvelComicListAdapter.fromJson(jsonData),
      );
    } on DioError catch (e) {
      return Left(
        WithoutDataException(
          message: e.message,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<WithoutDataException, MarvelCharacterListAdapter>>
      getCharacters([
    int? offset,
  ]) async {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    List<int> byteList =
        _utf8encoder.convert("$currentTimestamp$privateApiKey$publicApiKey");

    try {
      String hash = md5.convert(byteList).toString();

      Response response = await _dio.get(_charactersBaseUrl, queryParameters: {
        "apiKey": publicApiKey,
        "hash": hash,
        "ts": currentTimestamp,
      });

      Map<String, dynamic> jsonData = response.data["data"];

      return Right(
        MarvelCharacterListAdapter.fromJson(jsonData),
      );
    } on DioError catch (e) {
      return Left(
        WithoutDataException(
          message: e.message,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace.toString(),
        ),
      );
    }
  }
}
