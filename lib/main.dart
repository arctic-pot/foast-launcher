import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foast_launcher/base/game.dart' show GameData;
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/about_page.dart';
import 'package:foast_launcher/pages/accounts_page.dart';
import 'package:foast_launcher/pages/app_bar.dart';
import 'package:foast_launcher/pages/download_page.dart';
import 'package:foast_launcher/pages/games_page.dart';
import 'package:foast_launcher/pages/launch_page.dart';
import 'package:foast_launcher/pages/mods_page.dart';
import 'package:foast_launcher/pages/multiplayer_page.dart';
import 'package:foast_launcher/pages/server_page.dart';
import 'package:foast_launcher/pages/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
  doWhenWindowReady(() {
    const initSize = Size(1025, 700);
    appWindow.size = initSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Foast Launcher';
    appWindow.show();
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GameData>(create: (_) => GameData())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              iconTheme: const IconThemeData(color: Colors.black87, opacity: 1),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizationsDelegate.delegate
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('zh', 'CN'),
            ],
            home: const HomePage(title: 'Flutter Demo Home Page')));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return HomePageContent(title: title);
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  // region exclusive states
  // endregion
  // region top-level states, provide for some children widgets
  // endregion

  Widget _buildPageSwitcher(
      {required String title,
      required IconData icon,
      required Widget to,
      String? subtitle,
      bool disabled = false}) {
    return ListTile(
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        leading: Icon(icon),
        enabled: !disabled,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => to));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const CustomAppBar(
        title: 'Home',
        isStartPage: true,
      ),
      Expanded(
          flex: 1,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                //decoration: const BoxDecoration(color: Colors.white),
                child: ListView(
                  children: [
                    _buildPageSwitcher(
                        title: t(context, 'games'),
                        icon: FluentIcons.games_24_regular,
                        to: const GamesPage()),
                    _buildPageSwitcher(
                        title: t(context, 'accounts'),
                        icon: FluentIcons.person_24_regular,
                        to: const AccountsPage()),
                    _buildPageSwitcher(
                        title: t(context, 'mods'),
                        icon: FluentIcons.apps_24_regular,
                        to: const ModsPage()),
                    _buildPageSwitcher(
                        title: t(context, 'download'),
                        icon: FluentIcons.arrow_download_24_regular,
                        to: const DownloadPage()),
                    _buildPageSwitcher(
                        title: 'Server',
                        icon: FluentIcons.server_24_regular,
                        to: const ServerPage()),
                    _buildPageSwitcher(
                        title: 'Multiplayer',
                        icon: FluentIcons.people_24_regular,
                        to: const MultiplayerPage()),
                    const Divider(),
                    _buildPageSwitcher(
                        title: t(context, 'settings'),
                        icon: FluentIcons.settings_24_regular,
                        to: const SettingsPage()),
                    _buildPageSwitcher(
                        title: t(context, 'about'),
                        icon: FluentIcons.info_24_regular,
                        to: const AboutPage())
                  ],
                ),
              ),
              const VerticalDivider(
                width: 1,
              ),
              const Expanded(
                  flex: 1,
                  // Simple `if` statement
                  child: LaunchPage())
            ],
          ))
    ]));
  }

  void _ensureDirectories() {
    Directory('./.minecraft').create();
    Directory('./.minecraft/versions').create();
    Directory('./.minecraft/assets').create();
  }

  @override
  void initState() {
    super.initState();
    _ensureDirectories();
  }
}
