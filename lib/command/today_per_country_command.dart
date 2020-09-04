import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/command/command_utility.dart';
import 'package:covid_bot/covid_api/covid_api.dart';
import 'package:covid_bot/covid_api/model/stats_summary.dart';
import 'package:covid_bot/flag_utils.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:intl/intl.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:covid_bot/teledart_extension.dart';

class TodayPerCountryCommand extends Command {
  TodayPerCountryCommand() : super(name: TODAY_PER_COUNTRY);

  @override
  void execute(Message message, TeleDart teleDart) async {
    await teleDart.waitingInformation(message);

    final responseSummary = await getIt<CovidApi>().getSummary();
    await teleDart.replyMessage(message,
        'Please, insert your country. If you don\'t find it, use /${SUPPORTED_COUNTRIES} command.');

    final sub = teleDart.onMessage(entityType: '*').listen((message) {
      final countriesFound = _filterCountriesByUserText(responseSummary.data.countryStatList, message.text);
      if (countriesFound.length == 1) {
        _showCountryData(teleDart, message, countriesFound.first);
      }

      clearAllSubscriptions();
    });

    subscriptions.add(sub);
  }

  Iterable<CountryStats> _filterCountriesByUserText(List<CountryStats> countries, String userInput) {
    return countries.where(
      (country) => country.country.toLowerCase().contains(userInput.toLowerCase()),
    );
  }

  void _showCountryData(TeleDart teleDart, Message message, CountryStats country) async {
    final text = '''
Stats about ${country.country} ${emojiFlags[country.countryCode]}:
- Daily confirmed: ${country.newConfirmed} (Total: ${country.totalConfirmed})
- Daily deaths: ${country.newDeaths} (Total: ${country.totalDeaths})
- Daily recovered: ${country.newRecovered} (Total: ${country.totalRecovered})

(Last update: ${DateFormat('d MMMM y').format(DateTime.parse(country.date))})
''';

    await teleDart.replyMessage(message, text);
  }
}
