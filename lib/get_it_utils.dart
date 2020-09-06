import 'dart:io';

import 'package:covid_bot/client/http_client.dart';
import 'package:covid_bot/covid_api/covid_api.dart';
import 'package:get_it/get_it.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

final getIt = GetIt.instance;

void setupGetIt() async {
  final env = Platform.environment;
  final covid19HttpClient = HttpClient(baseUrl: 'https://api.covid19api.com');

  getIt.registerSingleton<HttpClient>(covid19HttpClient);
  getIt.registerSingleton<CovidApi>(CovidApi(covid19HttpClient));
  getIt.registerSingleton<TeleDart>(TeleDart(Telegram(env['TOKEN']), Event()));
}
