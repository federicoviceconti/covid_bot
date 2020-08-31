import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main(List<String> arguments) {
  var teledart = TeleDart(Telegram('[BOT_TOKEN]'), Event());

  teledart.start().then((me) => print(me.can_join_groups));

  teledart
      .onCommand('hello')
      .listen((message) => teledart.replyMessage(message, 'Stand with Hong Kong'));
}
