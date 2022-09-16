import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foast_launcher/base/game.dart' show GameData;
import 'package:foast_launcher/common.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/app_bar.dart';
import 'package:foast_launcher/pages/navigation.dart';
import 'package:provider/provider.dart';

void main() async {
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
        ChangeNotifierProvider<GameData>(create: (_) => GameData()),
        ChangeNotifierProvider<ShowingPage>(
            create: (_) => ShowingPage(SubPage.home)),
        ChangeNotifierProvider<GameRunning>(create: (_) => GameRunning(false))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.black87, opacity: 1),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(title: 'Foast Launcher'),
      ),
    );
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
  Widget _buildPageSwitcher(
      {required String title,
      required IconData icon,
      required SubPage to,
      String? subtitle,
      bool disabled = false}) {
    return ListTile(
      selected: to == context.watch<ShowingPage>().value,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      leading: Icon(icon),
      enabled: !(context.watch<GameRunning>().value || disabled),
      onTap: () => ShowingPage.change(context, to),
    );
  }

  Widget _buildSidebar() {
    return SizedBox(
      width: 200,
      //decoration: const BoxDecoration(color: Colors.white),
      child: Theme(
        data: navigationDrawerStyle(context),
        child: Theme(
          data: ThemeData(
            listTileTheme: ListTileThemeData(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              selectedTileColor:
                  Theme.of(context).primaryColorLight.withOpacity(0.4),
            ),
            splashFactory: NoSplash.splashFactory,
          ),
          child: ListView(
            padding: const EdgeInsets.all(4),
            children: [
              _buildPageSwitcher(
                title: l10n(context).home,
                icon: FluentIcons.home_24_regular,
                to: SubPage.home,
              ),
              _buildPageSwitcher(
                title: l10n(context).news,
                icon: FluentIcons.news_24_regular,
                to: SubPage.news,
              ),
              _buildPageSwitcher(
                title: l10n(context).games,
                icon: FluentIcons.games_24_regular,
                to: SubPage.games,
              ),
              _buildPageSwitcher(
                title: l10n(context).accounts,
                icon: FluentIcons.person_24_regular,
                to: SubPage.accounts,
              ),
              _buildPageSwitcher(
                title: l10n(context).mods,
                icon: FluentIcons.apps_24_regular,
                to: SubPage.mods,
              ),
              _buildPageSwitcher(
                title: l10n(context).download,
                icon: FluentIcons.arrow_download_24_regular,
                to: SubPage.download,
              ),
              _buildPageSwitcher(
                title: l10n(context).server,
                icon: FluentIcons.server_24_regular,
                to: SubPage.server,
              ),
              _buildPageSwitcher(
                title: l10n(context).multiplayer,
                icon: FluentIcons.people_24_regular,
                to: SubPage.multiplayer,
              ),
              const Divider(),
              _buildPageSwitcher(
                  title: l10n(context).settings,
                  icon: FluentIcons.settings_24_regular,
                  to: SubPage.settings),
              _buildPageSwitcher(
                  title: l10n(context).about,
                  icon: FluentIcons.info_24_regular,
                  to: SubPage.about)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const FoastAppBar(
            isStartPage: true,
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  _buildSidebar(),
                  const VerticalDivider(
                    width: 1,
                  ),
                  Expanded(
                      flex: 1,
                      // Simple `if` statement
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation.drive(Tween(begin: 0.0, end: 1.0)
                                .chain(CurveTween(curve: Curves.ease))),
                            child: child),
                        child: context.watch<ShowingPage>().widget,
                      ))
                ],
              ))
        ],
      ),
    );
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
