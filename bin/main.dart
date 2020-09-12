import 'dart:async';
import 'package:covid_bot/command/command_utility.dart';
import 'package:covid_bot/command/help_command.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:teledart/teledart.dart';

StreamSubscription streamStart;

void main() async {
  _startBotServer();
}

void _startBotServer() async {
  await setupGetIt();
  await _executeStartingActions();

  setupBotCommands();
}

void _executeStartingActions() async {
  await streamStart?.cancel();
  final teledart = getIt<TeleDart>();

  streamStart = teledart.onCommand('start').listen((message) {
    HelpCommand().execute(message, teledart);    
    streamStart?.cancel();
  });

  await teledart.start();
}
