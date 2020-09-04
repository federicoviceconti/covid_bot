import 'package:covid_bot/client/http_client.dart';
import 'package:covid_bot/client/result_response.dart';

abstract class BaseApi {
  HttpClient client;

  BaseApi(this.client);

  Future<ResultResponse<U>> makeGet<U>({String path, U Function(dynamic body) convertFunc}) async {
    final result = await client.makeGet(
      path: path,
      convertFunc: convertFunc
    );

    return result;
  }
}