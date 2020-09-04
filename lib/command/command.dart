import 'dart:async';

import 'package:teledart/model.dart';
import 'package:teledart/src/teledart/teledart.dart';

abstract class Command {
  String name;
  List<StreamSubscription> subscriptions = [];

  Command({
    this.name,
  });

  void execute(Message message, TeleDart teledart);

  Future<void> clearAllSubscriptions() async {
    subscriptions.forEach((element) async {
      await element?.cancel();
    });

    subscriptions.clear();
  }
}