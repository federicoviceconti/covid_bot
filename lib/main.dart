import 'dart:async';

import 'package:covid_bot/command/help_command.dart';
import 'package:covid_bot/get_it_utils.dart';
import 'package:teledart/teledart.dart';
import 'command/command_utility.dart';

StreamSubscription streamStart;

void main(List<String> arguments) async {
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
