import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/about_page.dart';
import 'package:foast_launcher/pages/accounts_page.dart';
import 'package:foast_launcher/pages/download_page.dart';
import 'package:foast_launcher/pages/games_page.dart';
import 'package:foast_launcher/pages/launch_page.dart';
import 'package:foast_launcher/pages/mods_page.dart';
import 'package:foast_launcher/pages/online_playing_page.dart';
import 'package:foast_launcher/pages/settings_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
        home: const HomePage(title: 'Flutter Demo Home Page'));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // region exclusive states
  // endregion
  // region top-level states, provide for some children widgets
  // endregion

  Widget _buildPageSwitcher(
      {required String title,
      required IconData icon,
      required Widget to,
      bool disabled = false}) {
    return ListTile(
        title: Text(title),
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
      Container(
        width: double.infinity,
        height: 42.5,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Foast Launcher',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )))
          ],
        ),
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
                        icon: Icons.widgets_rounded,
                        to: const GamesPage()),
                    _buildPageSwitcher(
                        title: t(context, 'accounts'),
                        icon: Icons.account_circle_rounded,
                        to: const AccountsPage()),
                    _buildPageSwitcher(
                        title: t(context, 'mods'),
                        icon: Icons.extension_rounded,
                        to: const ModsPage()),
                    _buildPageSwitcher(
                        title: t(context, 'download'),
                        icon: Icons.download_rounded,
                        to: const DownloadPage()),
                    _buildPageSwitcher(
                        title: 'Online Playing',
                        disabled: true,
                        icon: Icons.dns_rounded,
                        to: const OnlinePlayingPage()),
                    const Divider(),
                    _buildPageSwitcher(
                        title: t(context, 'settings'),
                        icon: Icons.settings_rounded,
                        to: const SettingsPage()),
                    _buildPageSwitcher(
                        title: t(context, 'about'),
                        icon: Icons.info_rounded,
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

  @override
  void initState() {
    super.initState();
    Directory('./.minecraft').createSync(recursive: true);
  }
}
