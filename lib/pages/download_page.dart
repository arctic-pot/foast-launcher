import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foast_launcher/common.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const versionManifestPath =
    'https://launchermeta.mojang.com/mc/game/version_manifest_v2.json';

class SelectedTab extends SingleValueChangeNotifier {
  SelectedTab(initValue) : super(initValue);
}

// class DownloadPage extends StatefulWidget {
//   const DownloadPage({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _DownloadPageState();
// }

enum DownloadTab {
  empty,
  games,
  mods,
  modPacks,
  resPacks,
  shader,
  java,
  serverCore
}

class DownloadPage extends StatelessWidget {
  final DownloadTab? initPage;
  const DownloadPage({Key? key, this.initPage}) : super(key: key);

  Widget _buildTab(BuildContext context,
      {required String title,
      required DownloadTab id,
      required IconData icon}) {
    return ListTile(
      title: Text(t(context, title)),
      selected: context.watch<SelectedTab>().value == id,
      onTap: () => context.read<SelectedTab>().value = id,
      leading: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectedTab>(
            create: (_) => SelectedTab(initPage ?? DownloadTab.empty))
      ],
      builder: (context, _) => SubPageScaffold(
        title: t(context, 'download'),
        child: Row(children: [
          // DefaultTabController(
          //   length: 4,
          //   child: TabBar(
          //     onTap: (int index) {
          //       context.read<SelectedTab>().value = index;
          //     },
          //     unselectedLabelColor:
          //         Theme.of(context).textTheme.caption?.color,
          //     labelColor: Theme.of(context).primaryColor,
          //     tabs: const [
          //       Tab(
          //         ,
          //         child: Text('Game'),
          //       ),
          //       Tab(
          //         icon: Icon(Icons.extension_rounded),
          //         child: Text('Mods'),
          //       ),
          //       Tab(
          //         icon: Icon(Icons.inventory_2_rounded),
          //         child: Text('Mod Packs'),
          //       ),
          //       Tab(
          //         icon: Icon(Icons.texture_rounded),
          //         child: Text('Resource Packs'),
          //       ),
          //     ],
          //   ),
          // ),
          Theme(
            data: navigationDrawerStyle(context),
            child: SizedBox(
              width: 200,
              height: double.maxFinite,
              child: ListView(
                children: [
                  _buildTab(
                    context,
                    title: 'games',
                    id: DownloadTab.games,
                    icon: FluentIcons.games_24_regular,
                  ),
                  _buildTab(
                    context,
                    title: 'mods',
                    id: DownloadTab.mods,
                    icon: FluentIcons.apps_24_regular,
                  ),
                  _buildTab(
                    context,
                    title: 'mod_packs',
                    id: DownloadTab.modPacks,
                    icon: FluentIcons.backpack_24_regular,
                  ),
                  _buildTab(
                    context,
                    title: 'res_packs',
                    id: DownloadTab.resPacks,
                    icon: FluentIcons.grid_24_regular,
                  ),
                  _buildTab(
                    context,
                    title: 'shader_packs',
                    id: DownloadTab.shader,
                    icon: FluentIcons.shape_subtract_24_regular,
                  ),
                  _buildTab(
                    context,
                    title: 'server_core',
                    id: DownloadTab.serverCore,
                    icon: FluentIcons.server_24_regular,
                  ),
                  _buildTab(
                    context,
                    title: 'java',
                    id: DownloadTab.java,
                    icon: FluentIcons.drink_coffee_24_regular,
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          ({
                DownloadTab.empty: _EmptyPart(),
                DownloadTab.java: _DownloadPageJavaPart(),
                DownloadTab.games: _DownloadPageGamesPart(),
              }[context.watch<SelectedTab>().value] ??
              _WIPPart())
        ]),
      ),
    ));
  }
}

class VersionManifest {
  Map<String, dynamic>? value;

  VersionManifest(this.value);
}

class _DownloadPageGamesPart extends StatelessWidget {
  List<Widget> _buildGameList(String type, BuildContext context) {
    final Map<String, dynamic> manifest =
        context.watch<VersionManifest>().value!;
    final List<dynamic> versions = List.from(manifest['versions']);
    final String releasedAt = t(context, 'released_at');
    final String unsecure = t(context, 'unsecure_version');
    versions.retainWhere((element) => element['type'] == type);
    return versions.map((version) {
      final releaseTime = DateTime.parse(version['releaseTime'])
          .toLocal()
          .toString()
          .substring(0, 19);
      final unsecureHint = version['complianceLevel'] == 1 ? '' : '| $unsecure';
      return ListTile(
        title: Text(version['id']!),
        subtitle: Text('$releasedAt $releaseTime $unsecureHint'),
        onTap: () {},
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FutureProvider<VersionManifest>(
          // bruh
          create: (_) => compute((_) async {
                final url = Uri.parse(versionManifestPath);
                final manifest = (await http.get(url)).body;
                return VersionManifest(json.decode(manifest));
              }, null),
          initialData: VersionManifest(null),
          builder: (context, _) => context.watch<VersionManifest>().value ==
                  null
              ? Center(child: Text(t(context, 'loading')))
              : SingleChildScrollView(
                  controller: ScrollController(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ExpansionPanelList.radio(
                          children: [
                            ExpansionPanelRadio(
                                headerBuilder: (context, __) => ListTile(
                                    title: Text(t(context, 'releases'))),
                                body: ListView(
                                    shrinkWrap: true,
                                    children:
                                        _buildGameList('release', context)),
                                value: 0),
                            ExpansionPanelRadio(
                                headerBuilder: (context, __) => ListTile(
                                    title: Text(t(context, 'snapshots'))),
                                body: ListView(
                                    shrinkWrap: true,
                                    children:
                                        _buildGameList('snapshot', context)),
                                value: 1),
                            ExpansionPanelRadio(
                                headerBuilder: (context, __) =>
                                    ListTile(title: Text(t(context, 'old'))),
                                body: ListView(shrinkWrap: true, children: [
                                  ..._buildGameList('old_beta', context),
                                  ..._buildGameList('old_alpha', context),
                                ]),
                                value: 2),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}

class _DownloadPageJavaPart extends StatelessWidget {
  Widget _buildJavaCard(context,
      {required String jdk, required String mc, bool includeOracle = false}) {
    final titleStyle = Theme.of(context).textTheme.headline4;
    final descStyle = Theme.of(context).textTheme.bodyText1;
    return Card(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(jdk, style: titleStyle),
            Text(mc, style: descStyle),
            const Divider(),
            Row(
              children: [
                Text(t(context, 'distributor') + ': '),
                const SizedBox(width: 5),
                TextButton(onPressed: () {}, child: const Text('BellSoft')),
                const SizedBox(width: 5),
                TextButton(onPressed: () {}, child: const Text('Microsoft')),
                if (includeOracle) const SizedBox(width: 5),
                if (includeOracle)
                  TextButton(onPressed: () {}, child: const Text('Oracle')),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildJavaCard(context, jdk: 'Java 8', mc: 'Minecraft 1.16.5-'),
              _buildJavaCard(context, jdk: 'Java 11', mc: 'Minecraft 1.16.5-'),
              _buildJavaCard(context, jdk: 'Java 16', mc: 'Minecraft 1.17'),
              _buildJavaCard(context,
                  jdk: 'Java 17', mc: 'Minecraft 1.18+', includeOracle: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}

class _WIPPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('WIP');
  }
}
