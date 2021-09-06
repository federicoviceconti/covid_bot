# CODIV-19 Bot

Now available at account **[@Covid_Info_19_Bot](https://t.me/Covid_Info_19_Bot)**.

NB: the bot is hosted on Heroku with a free plan. The dyno has a limitation, based on active hours

This bot will show all the information about COVID-19. Built with Dart and [teledart](https://pub.dev/packages/teledart) library.

Current todo:
- adding more commands

I made a simple and brief tutorial on Medium: [how to create bot with Dart and TeleDart package and deploy on Heroku](https://medium.com/@viceconti.federico/how-to-deploy-your-telegram-bot-on-heroku-with-teledart-6ee197c0df91)

### Command supported

**Data**
- /today_per_country - show data per country on current day
- /today_global - show global data on current day
- /stats_period - show data filtered by period (week, month)

**Help**
- /supported_countries - get all available countries supported by the bot
- /search_supported_country - search if the input country is supported
- /help - show all available commands
- /up - check if bot is running, replying with a simple message

### How to deploy locally
Steps to deploy the bot in local environment:
1. Create a new bot using BotFather on Telegram
2. Change into assets/environment.json the api-key
3. Run locally and send the command into the input field

### Credits

**API**: 
- [covid19api](https://covid19api.com/), a free API for data on the Coronavirus. Data is sourced from Johns Hopkins CSSE.

**Icon**: 
- [Covid Bot icon](https://www.iconfinder.com/icons/5960676/coronavirus_covid_covid-19_disease_infection_virus_icon)
