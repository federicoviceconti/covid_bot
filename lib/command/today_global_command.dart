import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/command/command_utility.dart';
import 'package:covid_bot/covid_api/covid_api.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:intl/intl.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:covid_bot/teledart_extension.dart';

class TodayGlobalCommand extends Command {
  TodayGlobalCommand() : super(name: TODAY_GLOBAL);

  @override
  void execute(Message message, TeleDart teleDart) async {
    await teleDart.waitingInformation(message);
    final response = await getIt<CovidApi>().getSummary();
    final globalStats = response.data.globalStats;
    final today = DateTime.now();

    await teleDart.replyMessage(
        message, '''Global Stats about ${DateFormat('d MMMM y').format(today)} 😷:
- New case confirmed: ${globalStats.newConfirmed} (Total: ${globalStats.totalConfirmed})
- New case deaths: ${globalStats.newDeaths} (Total: ${globalStats.totalDeaths})
- New case recovered: ${globalStats.newRecovered} (Total: ${globalStats.totalRecovered})
''');
  }
}
