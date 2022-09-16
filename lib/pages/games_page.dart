import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foast_launcher/base/game.dart';
import 'package:foast_launcher/common.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';
import 'package:foast_launcher/pages/download_page.dart';
import 'package:foast_launcher/pages/version_list.dart';
import 'package:provider/provider.dart';

const double _width = 285;

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _GamesPageState();
}

// todo: Put "Game path" into settings, "Add or import" move to the bottom as a button bar, "Operations" move to version_list.dart.

class _GamesPageState extends State<GamesPage> {
  List<Game>? _games;

  void _refreshGameList({bool resetIndex = false}) {
    // Versions could be very many, here we put it into an isolate task
    compute(Game.loadFromPath, _getSelectedPath()).then((value) {
      setState(() {
        _games = value;
      });
      if (resetIndex) {
        context.read<GameData>().selected =
            value.isNotEmpty ? value[0] : EmptyGame();
      } else {
        // For a unknown bug
        context.read<GameData>().selected = context.read<GameData>().selected;
      }
    });
  }

  String _getSelectedPath() {
    return context.read<GameData>().standardPath
        ? getStandardPath()
        : './.minecraft';
  }

  void _handleChangePath(bool? newValue, {bool resetIndex = true}) {
    context.read<GameData>().standardPath = newValue!;
    _refreshGameList(resetIndex: resetIndex);
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

  Widget _alertDelete(BuildContext context) => AlertDialog(
        title: Text(l10n(context).deleteVersionAsk),
        content: Text(l10n(context).warnDeleteVersion),
        actions: [
          TextButton(
              onPressed: () {
                _deleteCurrentVersion();
                Navigator.of(context).pop(true);
              },
              child: Text(l10n(context).deleteVersion)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(l10n(context).cancel)),
        ],
      );

  // Widget _buildSingleVersionCard(
  //     {required Widget icon,
  //     required String title,
  //     required String installed,
  //     required bool active,
  //     required onTap}) {
  //   return Center(
  //     child: Card(
  //       elevation: active ? 1 : 0,
  //       color:
  //           active ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
  //       child: ListTile(
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(5))),
  //         selected: active,
  //         leading: icon,
  //         title: Text(title),
  //         subtitle: Text(installed),
  //         onTap: (!active) ? onTap : null,
  //       ),
  //     ),
  //   );
  // }
  //
  // List<Widget> _buildVersionCards(List<Game> versions) {
  //   return versions
  //       .asMap()
  //       .map((index, game) {
  //         return MapEntry(
  //             index,
  //             _buildSingleVersionCard(
  //                 icon: Text('${game.icon.index}'),
  //                 title: game.version.displayName,
  //                 installed: game.getInstalled(context),
  //                 active: context.read<GameData>().selected.displayName ==
  //                     _games![index].displayName,
  //                 onTap: () {
  //                   context.read<GameData>().selected = _games![index];
  //                 }));
  //       })
  //       .values
  //       .toList();
  // }

  void _deleteCurrentVersion() {
    final Game? _selectedGame = context.read<GameData>().selected;
    if (_selectedGame != null) {
      Directory(_selectedGame.path).delete(recursive: true);
      // Can't find a semantic name
      context.read<GameData>().selected = _games![0];
      _refreshGameList();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final _selectedGameIndex = _games?.indexWhere((game) =>
    //game.displayName == context.read<GameData>().selected.displayName) ?? 0;
    return Column(children: [
      Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: (_games?.isNotEmpty ?? true)
                      ? VersionList(
                        games: _games,
                        showSelected: true,
                        onSelect: (version) =>
                            context.read<GameData>().selected = version,
                      )
                      : Center(
                          child: Text(l10n(context).noGamesInstalled,
                              style: Theme.of(context).textTheme.caption),
                        )),
              ButtonBar(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.add_24_regular),
                    label: Text(l10n(context).addOrImport),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.arrow_download_24_regular),
                    label: Text(l10n(context).installVersion),
                  ),
                ],
              )
            ],
          )
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //         width: _width,
          //         child: Column(
          //           children: [
          //             _buildSubtitle(l10n(context).gamePath),
          //             Theme(
          //               data: navigationDrawerStyle(context),
          //               child: ListView(
          //                 shrinkWrap: true,
          //                 children: [
          //                   ListTile(
          //                     title: Text(l10n(context).pathCurrent),
          //                     selected: !context.watch<GameData>().standardPath,
          //                     onTap: () {
          //                       context.read<GameData>().standardPath = false;
          //                       _refreshGameList(resetIndex: true);
          //                     },
          //                   ),
          //                   ListTile(
          //                     title: Text(l10n(context).pathOfficial),
          //                     selected: context.watch<GameData>().standardPath,
          //                     onTap: () {
          //                       context.read<GameData>().standardPath = true;
          //                       _refreshGameList(resetIndex: true);
          //                     },
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             _buildSubtitle(l10n(context).addOrImport),
          //             ListView(
          //               shrinkWrap: true,
          //               children: [
          //                 ListTile(
          //                   title: Text(l10n(context).addGamePath),
          //                   leading: const Icon(
          //                       FluentIcons.folder_add_24_regular),
          //                   enabled: false,
          //                 ),
          //                 ListTile(
          //                   title: Text(l10n(context).installVersion),
          //                   leading: const Icon(
          //                       FluentIcons.arrow_download_24_regular),
          //                   onTap: () {
          //                     navigateToWidget(
          //                         context,
          //                         const DownloadPage(
          //                             initPage: DownloadTab.games));
          //                   },
          //                 ),
          //                 ListTile(
          //                   title: Text(l10n(context).importModpack),
          //                   leading: const Icon(FluentIcons.add_24_regular),
          //                   enabled: false,
          //                 ),
          //               ],
          //             ),
          //             _buildSubtitle(l10n(context).operations),
          //             ListView(
          //               shrinkWrap: true,
          //               children: [
          //                 ListTile(
          //                     enabled: _games != null,
          //                     title: Text(l10n(context).deleteVersion),
          //                     leading:
          //                         const Icon(FluentIcons.delete_24_regular),
          //                     onTap: () {
          //                       showDialog(
          //                           context: context, builder: _alertDelete);
          //                     }),
          //                 ListTile(
          //                     enabled: _games != null,
          //                     title: Text(l10n(context).refresh),
          //                     leading: const Icon(
          //                         FluentIcons.arrow_clockwise_24_regular),
          //                     onTap: () {
          //                       _refreshGameList();
          //                     }),
          //               ],
          //             ),
          //           ],
          //         )),
          //     const VerticalDivider(width: 1),
          //     // Expanded(
          //     //     flex: 1,
          //     //     child: (_games?.isNotEmpty ?? true)
          //     //         ? GridView.count(
          //     //             crossAxisSpacing: 10.0,
          //     //             mainAxisSpacing: 10.0,
          //     //             padding: const EdgeInsets.all(10.0),
          //     //             crossAxisCount: 2,
          //     //             childAspectRatio: 4.5,
          //     //             controller: ScrollController(),
          //     //             children: _buildVersionCards(_games ?? []))
          //     //         : Center(
          //     //             child: Text(t(context, 'no_games_installed'),
          //     //                 style: Theme.of(context).textTheme.caption),
          //     //           ))
          //   ],
          // ),
          )
    ]);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      _refreshGameList();
      _handleChangePath(/*context.read<GameData>().standardPath*/ true,
          resetIndex: false);
    });
  }
}
