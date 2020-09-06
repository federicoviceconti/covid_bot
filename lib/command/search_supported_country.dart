import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/command/command_utility.dart';
import 'package:covid_bot/covid_api/covid_api.dart';
import 'package:covid_bot/flag_utils.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:covid_bot/teledart_extension.dart';
import 'package:teledart/src/telegram/model.dart';
import 'package:teledart/teledart.dart';

class SearchSupportCountry extends Command {
  SearchSupportCountry() : super(name: SEARCH_SUPPORTED_COUNTRY);

  @override
  void execute(Message message, TeleDart teleDart) async {
    await teleDart.replyMessage(message, 'Please input something and I will let you know which countries are supported! 😁');
    
    final subscription = teleDart.onMessage(entityType: '*').listen((countryInputMessage) async {
      await teleDart.waitingInformation(message);
      final response = await getIt<CovidApi>().getCountries();

      final countriesFound = response.data.countries
        .where((country) => country.name.toLowerCase().contains(countryInputMessage.text.toLowerCase()))
        .map((country) {
          return '${emojiFlags[country.isoCode]} ${country.name}, ';
        })
        .join();
      
      if(countriesFound.isNotEmpty) {
        final messageCountriesFoundFormatted = countriesFound.substring(0, countriesFound.lastIndexOf(', '));
        if(messageCountriesFoundFormatted.isNotEmpty) {
          await teleDart.replyAndCutOffMessage(message, 'Countries:\n$messageCountriesFoundFormatted');
        }
      }

      await clearAllSubscriptions();
    });

    subscriptions.add(subscription);
  }
}
