import 'package:flutter/material.dart';
import 'package:foast_launcher/common.dart';
import 'package:foast_launcher/pages/about_page.dart';
import 'package:foast_launcher/pages/accounts_page.dart';
import 'package:foast_launcher/pages/download_page.dart';
import 'package:foast_launcher/pages/games_page.dart';
import 'package:foast_launcher/pages/home_page.dart';
import 'package:foast_launcher/pages/mods_page.dart';
import 'package:foast_launcher/pages/multiplayer_page.dart';
import 'package:foast_launcher/pages/server_page.dart';
import 'package:foast_launcher/pages/settings_page.dart';
import 'package:provider/provider.dart';

enum SubPage {
  about,
  accounts,
  download,
  games,
  home,
  mods,
  multiplayer,
  server,
  settings,
  news
}

class ShowingPage extends SingleValueChangeNotifier<SubPage> {
  ShowingPage(initValue) : super(initValue);

  static void change(BuildContext context, SubPage to) {
     context.read<ShowingPage>().value = to;
  }

  get widget {
    return {
      SubPage.about: const AboutPage(),
      SubPage.accounts: const AccountsPage(),
      SubPage.download: const DownloadPage(),
      SubPage.games: const GamesPage(),
      SubPage.home: const LaunchPage(),
      SubPage.mods: const ModsPage(),
      SubPage.multiplayer: const MultiplayerPage(),
      SubPage.server: const ServerPage(),
      SubPage.settings: const SettingsPage(),
      // well it's just a placeholder.
      SubPage.news: const ModsPage(),
    }[value];
  }
}
