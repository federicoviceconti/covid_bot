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
This bot is used to find data about the new virus: COVID-19.
You can control me by sending these commands:

*Data*
/${TODAY_PER_COUNTRY} show data per country on current day
/${TODAY_GLOBAL} show global data on current day
/${STATS_PERIOD} show data filtered by period

*Help*
/${SUPPORTED_COUNTRIES} get all available countries supported by the bot
/${SEARCH_SUPPORTED_COUNTRY} search if the input country is supported
/${HELP} show all available commands

Hey! If you want to contribute, you can found this project on github also:
https://github.com/federicoviceconti/covid_bot

Enjoy! 🌈
'''.espaceCharacters(), parse_mode: 'MarkdownV2');
  }
}