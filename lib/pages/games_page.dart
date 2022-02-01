import 'package:flutter/material.dart';
import 'package:foast_launcher/base/game/game.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/app_bar.dart';
import 'package:foast_launcher/pages/download_page.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final double _width = 285;
  int _radioGroupValue = 0;
  int _selectedVersionIndex = 0;
  List<Game>? _games = null;

  void _handleChangePath(int? newValue) {
    setState(() {
      _radioGroupValue = newValue ?? 0;
    });
  }

  Widget _buildSubtitle(String text) {
    return Container(
      width: _width,
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildSingleVersionCard(
      {required Widget icon,
      required String title,
      required String installed,
      required bool active,
      required onTap}) {
    return Center(
      child: Card(
        elevation: active ? 1.5 : 0,
        //color:  ? Theme.of(context).primaryColorLight : null,
        child: ListTile(
          selected: active,
          leading: icon,
          title: Text(title),
          subtitle: Text(installed),
          onTap: (!active) ? onTap : null,
        ),
      ),
    );
  }

  List<Widget> _buildVersionCards(List<Game> versions) {
    return versions
        .asMap()
        .map((index, game) {
          return MapEntry(
              index,
              _buildSingleVersionCard(
                  icon: Text('${game.icon.index}'),
                  title: game.version.displayName,
                  installed: game.getInstalled(context),
                  active: _selectedVersionIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedVersionIndex = index;
                    });
                  }));
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SubpageAppBar(
        title: t(context, 'games'),
      ),
      Expanded(
        flex: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: _width,
                child: Column(
                  children: [
                    _buildSubtitle(t(context, 'game_path')),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        RadioListTile(
                          title: Text(t(context, 'path_current')),
                          value: 0,
                          groupValue: _radioGroupValue,
                          onChanged: _handleChangePath,
                        ),
                        RadioListTile(
                          title: Text(t(context, 'path_official')),
                          value: 1,
                          groupValue: _radioGroupValue,
                          onChanged: _handleChangePath,
                        ),
                      ],
                    ),
                    _buildSubtitle(t(context, 'add_or_import')),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          title: Text(t(context, 'install_version')),
                          leading: const Icon(Icons.download_rounded),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const DownloadPage()));
                          },
                        ),
                        ListTile(
                          title: Text(t(context, 'import_modpack')),
                          leading: const Icon(Icons.add_circle_rounded),
                          enabled: false,
                        ),
                      ],
                    ),
                  ],
                )),
            const VerticalDivider(width: 1),
            Expanded(
                flex: 1,
                child: (_games?.isNotEmpty ?? true)
                    ? GridView.count(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        padding: const EdgeInsets.all(10.0),
                        crossAxisCount: 2,
                        childAspectRatio: 4.5,
                        controller: ScrollController(),
                        children: _buildVersionCards(_games ?? []))
                    : Center(
                        child: Text(t(context, 'no_games_installed'),
                            style: Theme.of(context).textTheme.caption),
                      ))
          ],
        ),
      )
    ]));
  }

  @override
  void initState() {
    super.initState();
    Game.loadFromPath().then((value) => setState(() {
          _games = value;
        }));
  }
}
