import 'dart:convert';

import 'package:http/http.dart' as http;
import 'result_response.dart';

class HttpClient {
  String baseUrl;
  http.Client client;

  HttpClient({
    this.baseUrl,
  }) : client = http.Client();

  Future<ResultResponse<U>> makeGet<U, T extends ResultResponse<U>>({
    String path,
    U Function(dynamic body) convertFunc,
  }) async {
    final response = await http.get('$baseUrl$path');
    return ResultResponse.fromResponse(
      httpCode: response.statusCode,
      result: convertFunc(json.decode(response.body)),
    );
  }
}
