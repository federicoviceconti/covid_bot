import 'dart:async';

import 'package:covid_bot/client/result_response.dart';
import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/covid_api/covid_api.dart';
import 'package:covid_bot/covid_api/model/countries.dart';
import 'package:covid_bot/covid_api/model/day_country_case.dart';
import 'package:covid_bot/flag_utils.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:intl/intl.dart';
import 'package:teledart/src/teledart/model/message.dart';
import 'package:teledart/src/teledart/teledart.dart';
import 'package:teledart/src/telegram/model.dart';
import 'package:covid_bot/teledart_extension.dart';

class StatsPeriodCommand extends Command {
  final covidApi = getIt<CovidApi>();

  StatsPeriodCommand() : super(name: 'stats_period');

  @override
  void execute(Message message, TeleDart teledart) async {
    final response = await covidApi.getCountries();
    final countries = response.data.countries;
    await teledart.insertYourCountryInfo(message);

    subscriptions.add(teledart.onMessage(entityType: '*').listen((message) async {
      _searchDataByCountry(teledart, message, countries);
    }));
  }

  DayCountryCase _getPreviousDay(List<DayCountryCase> days, int index) {
    try {
      return days[index - 1];
    } catch (e) {
      return null;
    }
  }

  int _getDays(String text) {
    if (text.contains('week')) {
      return 7;
    } else if (text.contains('month')) {
      return 31;
    } else if (text.contains('year')) {
      return 365;
    }

    return 0;
  }

  void _searchDataByCountry(
    TeleDart teledart,
    TeleDartMessage message,
    List<Country> countries,
  ) async {
    final country = countries.firstWhere(
        (country) =>
            country.name.toLowerCase().contains(message.text.toLowerCase()),
        orElse: () => null);

    if (country != null) {
      final totalCaseResponse =
          await covidApi.getTotalCasesByCountry(country.slug);

      _filterSearchedDataByPeriod(
          teledart, message, totalCaseResponse, country);
    }
  }

  void _filterSearchedDataByPeriod(
      TeleDart teledart,
      Message message,
      ResultResponse<DayCountryCaseList> totalCaseResponse,
      Country country) async {
    await teledart.replyMessage(
        message, 'Insert the period [week|month|year]:');

    final subscription = teledart.onMessage(entityType: '*').listen((message) async {
      final headerText =
          'Stats about ${message.text} period on country ${country.name} ${emojiFlags[country.isoCode]}:';

      final cases = totalCaseResponse.data.dayCases;
      final period = _getDays(message.text);
      final casesLength = cases.length;

      await teledart.replyMessage(message, headerText);

      for (var index = 0; index < period; index++) {
        final day = cases[casesLength - (period - index)];
        final previousDay = _getPreviousDay(cases, index);

        var previousDayConfirmed = '';
        var previousDayRecovered = '';

        if (previousDay != null) {
          final confirmedDifference =
              (day.confirmed - previousDay.confirmed).abs();
          final recoveredDifference =
              (day.recovered - previousDay.recovered).abs();

          final isMajorConfirmed = day.confirmed > previousDay.confirmed;
          final isMajorRecovered = day.recovered > previousDay.recovered;

          final previousConfirmedStats = isMajorConfirmed ? '📈➕' : '📉➖';
          previousDayConfirmed = previousDay != null &&
                  previousDay.confirmed > 0
              ? '$previousConfirmedStats${previousDay.confirmed} on previous day $confirmedDifference'
              : '';

          final previousRecoveredStats = isMajorRecovered ? '📈➕' : '📉➖';
          previousDayRecovered = previousDay != null &&
                  previousDay.recovered > 0
              ? '$previousRecoveredStats${previousDay.recovered} previous day $recoveredDifference'
              : '';
        }

        final date =
            DateFormat('dd MMMM y').format(DateTime.parse(day.dateTime));
        final bodyText = '''
*Date: ${date}*
Confirmed: ${day.confirmed} ${previousDayConfirmed}
Recovered: ${day.recovered} ${previousDayRecovered}\n
''';
        await teledart.replyMessage(
            message,
            '''
              ${bodyText}
              ''',
            parse_mode: 'MarkdownV2');
      }

      await clearAllSubscriptions();
    });

    subscriptions.add(subscription);
  }
}
