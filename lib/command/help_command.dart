import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/command/command_utility.dart';
import 'package:teledart/src/teledart/teledart.dart';
import 'package:teledart/src/telegram/model.dart';
import 'package:covid_bot/string_extension.dart';

class HelpCommand extends Command {
  HelpCommand(): super(name: HELP);

  @override
  Future<void> execute(Message message, TeleDart teledart) async {
    await teledart.replyMessage(message, '''
This bot is used to find data about the new virus: COVID\\-19\\.
You can control me by sending these commands:

*Data*
/${TODAY_PER_COUNTRY.espaceCharacters()} show data per country on current day
/${TODAY_GLOBAL.espaceCharacters()} show global data on current day
/${STATS_PERIOD.espaceCharacters()} show data filtered by period

*Help*
/${SUPPORTED_COUNTRIES.espaceCharacters()} get all available countries supported by the bot
/${SEARCH_SUPPORTED_COUNTRY.espaceCharacters()} search if the input country is supported
/${HELP} show all available commands
''', parse_mode: 'MarkdownV2');
  }
}