import 'package:covid_bot/command/help_command.dart';
import 'package:covid_bot/command/is_bot_up_command.dart';
import 'package:covid_bot/command/search_supported_country.dart';
import 'package:covid_bot/command/stats_period_command.dart';
import 'package:covid_bot/command/supported_countries.dart';
import 'package:covid_bot/command/today_global_command.dart';
import 'package:covid_bot/command/today_per_country_command.dart';
import 'package:teledart/teledart.dart';

import '../get_it_utils.dart';

const TODAY_PER_COUNTRY = 'today_per_country';
const TODAY_GLOBAL = 'today_global';
const SUPPORTED_COUNTRIES = 'supported_countries';
const SEARCH_SUPPORTED_COUNTRY = 'search_supported_country';
const STATS_PERIOD = 'stats_period';
const HELP = 'help';
const IS_BOT_UP = 'up';

final commandListSupported = [
  SupportedCountries(),
  TodayGlobalCommand(),
  IsBotUpCommand(),
  TodayPerCountryCommand(), 
  HelpCommand(),
  SearchSupportCountry(),
  StatsPeriodCommand()
];

void setupBotCommands() {
  final teledart = getIt<TeleDart>();

  commandListSupported.forEach((command) {
    teledart
        .onCommand(command.name)
        .listen((message) => command.execute(message, teledart));
  });
}
