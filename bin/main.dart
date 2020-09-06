import 'dart:async';
import 'package:covid_bot/command/command_utility.dart';
import 'package:covid_bot/command/help_command.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:teledart/teledart.dart';

StreamSubscription streamStart;

void main() async {
  runZoned(() {
    _startBotServer();
  }, onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
}

void _startBotServer() async {
  await setupGetIt();
  final teledart = getIt<TeleDart>();
  await _executeStartingActions(teledart);

  setupBotCommands();
}

void _executeStartingActions(TeleDart teledart) async {
  await streamStart?.cancel();

  streamStart = teledart.onMessage(entityType: '*').listen((message) {
    HelpCommand().execute(message, teledart);    
    streamStart?.cancel();
  });

  await teledart.start();
}
