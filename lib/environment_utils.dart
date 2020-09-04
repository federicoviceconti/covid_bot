import 'dart:convert';
import 'dart:io';
import 'package:covid_bot/string_extension.dart';

enum Environment {
  apiBotKey
}

Future<Map<String, String>> _getKeyValuesFromEnvironment() async {
  final fileContent = await File('${Directory.current.path}/assets/environment.json').readAsString();
  return Map.castFrom(json.decode(fileContent));
}

Future<String> getValueFromEnvironmentKey(Environment key) async {
  final environmentMap = await _getKeyValuesFromEnvironment();
  final keyConverted = key.toString().getEnumValue();
  return environmentMap[keyConverted];
}