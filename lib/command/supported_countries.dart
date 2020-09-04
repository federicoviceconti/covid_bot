import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/command/command_utility.dart';
import 'package:covid_bot/covid_api/covid_api.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:teledart/src/telegram/model.dart';
import 'package:teledart/teledart.dart';

class SupportedCountries extends Command {
  SupportedCountries() : super(name: SUPPORTED_COUNTRIES);

  @override
  void execute(Message message, TeleDart teleDart) async {
    final response = await getIt<CovidApi>().getCountries();
    final countries = response.data.countries.map((country) {
      return '- ${country.name}\n';
    }).join();

    await teleDart.replyMessage(message, '''
Countries:
${countries}
''');
  }
}
