import 'package:covid_bot/command/command.dart';
import 'package:covid_bot/command/command_utility.dart';
import 'package:teledart/src/teledart/teledart.dart';
import 'package:teledart/src/telegram/model.dart';

class IsBotUpCommand extends Command {
  final String meme = 'https://image.slidesharecdn.com/devopsdayemcworld2015-memes-final-150501164657-conversion-gate02/95/devops-memes-emcworld-2015-28-638.jpg?cb=1430517087';
  final String caption = 'Hello, everything is working fine!';

  IsBotUpCommand(): super(name: IS_BOT_UP);

  @override
  Future<void> execute(Message message, TeleDart teledart) async {
    await teledart.replyPhoto(message, meme, caption: caption);
  }

}