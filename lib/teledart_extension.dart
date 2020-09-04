import 'package:covid_bot/command/command_utility.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

extension TeleDartExtension on TeleDart {
  static const int MAX_MESSAGE_LENGTH_TELEGRAM = 4096;

  void replySequentialMessage(Message message, String text, {String parseMode}) async {
    var currentIndexSplit = 0;

    while(currentIndexSplit < text.length - 1) {
      final splitIndex = currentIndexSplit + MAX_MESSAGE_LENGTH_TELEGRAM;
      final nextSplitIndex = splitIndex < text.length
        ? splitIndex
        : text.length - 1;

      final messageToSend = text.substring(currentIndexSplit, nextSplitIndex);
      await replyMessage(message, messageToSend, parse_mode: parseMode);

      currentIndexSplit = nextSplitIndex;
    }
  }

  void replyAndCutOffMessage(Message message, String text) async {
    final trucatedMessage = text.substring(0, text.length < (MAX_MESSAGE_LENGTH_TELEGRAM - 3) ? text.length : MAX_MESSAGE_LENGTH_TELEGRAM - 3);
    await replyMessage(message, '$trucatedMessage...');
  }

  void waitingInformation(Message message) async {
    await replyMessage(message, 'Retrieve information, wait a moment...');
  }

  void insertYourCountryInfo(Message message) async {
    await replyMessage(message,
        'Please, insert your country. If you don\'t find it, use /${SUPPORTED_COUNTRIES} command.');
  }
}