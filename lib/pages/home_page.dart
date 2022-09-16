import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foast_launcher/base/game.dart' show Game, GameData;
import 'package:foast_launcher/common.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/games_page.dart';
import 'package:foast_launcher/pages/navigation.dart';
import 'package:foast_launcher/pages/version_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

const _launchButtonWidth = 200.0;

// class OperationBarNotchedShape extends NotchedShape {
//   final BuildContext context;
//   const OperationBarNotchedShape(this.context);
//
//   @override
//   Path getOuterPath(Rect host, Rect? guest) {
//     // HELP FIX THIS
//     const radius = _launchButtonWidth;
//     const lx = 20.0;
//     const ly = 16;
//     const bx = 10.0;
//     const by = 32.0;
//     var x = (MediaQuery.of(context).size.width - radius - 201) / 2 - lx;
//     return Path()
//       ..moveTo(host.left, host.top)
//       ..lineTo(x, host.top)
//       ..quadraticBezierTo(x + bx, host.top, x += lx, host.top + ly)
//       ..quadraticBezierTo(
//           x + radius / 2, host.top + by, x += radius, host.top + ly)
//       ..quadraticBezierTo((x += lx) - bx, host.top, x, host.top)
//       ..lineTo(host.right, host.top)
//       ..lineTo(host.right, host.bottom)
//       ..lineTo(host.left, host.bottom);
//   }
// }

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  void _popupVersionSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n(context).selectVersion),
        children: [
          SizedBox(
            width: 500,
            child: FutureProvider<List<Game>>(
              create: (context) => compute(
                  Game.loadFromPath, context.read<GameData>().selectedPath),
              initialData: const [],
              builder: (context, _) => VersionList(
                games: context.watch<List<Game>>(),
                onSelect: (game) {
                  context.read<GameData>().selected = game;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      navigateToWidget(context, const GamesPage());
                    },
                    child: Text(l10n(context).manageVersions))
              ],
            ),
          )
        ],
      ),
    );
  }

  void Function() _launchGame(BuildContext context) => () {
        Process.start('ping', ['unexistwebsite.org']).then((process) {
          context.read<GameRunning>().value = true;
          process.exitCode.then((_) {
            context.read<GameRunning>().value = false;
          });
        });
      };

  // context.watch<GameRunning>().value
  Widget _buildBottomCard({required onTap, required title, required text}) {
    return Builder(builder: (context) {
      return Expanded(
        flex: 1,
        child: SizedBox(
          height: double.maxFinite,
          child: InkWell(
            onTap: context.watch<GameRunning>().value ? null : onTap,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontSize: 14),
                  ),
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedGame = context.watch<GameData>().selected;

    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white70,
                    height: 100,
                    child: Row(
                      children: [
                        _buildBottomCard(
                          onTap: () =>
                              ShowingPage.change(context, SubPage.games),
                          title: l10n(context).game,
                          text: context.watch<GameData>().selected.displayName,
                        ),
                        _buildBottomCard(
                          onTap: () => ShowingPage.change(context, SubPage.accounts),
                          title: l10n(context).account,
                          text: 'ACCOUNT WIP',
                        ),
                        _buildBottomCard(
                          onTap: () {},
                          title: l10n(context).java,
                          text: 'Default Java',
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Divider(),
                  height: 1,
                ),
                Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: _launchButtonWidth,
                      child: AnimatedOpacity(
                        opacity: context.watch<GameRunning>().value ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.ease,
                        child: FloatingActionButton.extended(
                          elevation:
                              context.watch<GameRunning>().value ? 0.0 : null,
                          onPressed: context.watch<GameRunning>().value
                              ? null
                              : _launchGame(context),
                          label: Text(l10n(context).launch),
                          icon: const Icon(FluentIcons.rocket_24_regular),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   width: 200,
                    //   child: ElevatedButton.icon(
                    //     onPressed: context.watch<GameRunning>().value
                    //         ? null
                    //         : _launchGame(context),
                    //     icon: const Icon(FluentIcons.rocket_24_regular),
                    //     label: context.watch<GameRunning>().value
                    //         ? Text(l10n(context).gameIsRunning)
                    //         : Text(l10n(context).launch),
                    //     style: ButtonStyle(
                    //         textStyle: MaterialStateProperty.all(
                    //             const TextStyle(fontSize: 20))),
                    //   ),
                    // ),
                  ),
                )
                // Row(
                //   children: [
                //     Column(
                //       children: [
                //         SizedBox(
                //           height: 35,
                //           width: 180,
                //           child: OutlinedButton.icon(
                //             onPressed: () {
                //               // Navigator.of(context).push(MaterialPageRoute(
                //               //     builder: (context) => const GamesPage()));
                //               _popupVersionSelector(context);
                //             },
                //             icon: const Icon(FluentIcons.games_24_regular),
                //             label: Text(l10n(context).selectVersion),
                //           ),
                //         ),
                //         const SizedBox(height: 10),
                //         SizedBox(
                //           height: 35,
                //           width: 180,
                //           child: OutlinedButton.icon(
                //             onPressed: () {
                //               navigateToWidget(
                //                   context, const AccountsPage());
                //             },
                //             icon: const Icon(FluentIcons.person_24_regular),
                //             label: Text(l10n(context).manageAccounts),
                //           ),
                //         ),
                //       ],
                //     ),
                //     const SizedBox(width: 10),
                //     SizedBox(
                //       width: 250,
                //       height: 80,
                //       child: ElevatedButton(
                //         onPressed: selectedGame.empty ? null : () {},
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               l10n(context).launch,
                //               style: TextStyle(
                //                   fontSize: Theme.of(context)
                //                       .textTheme
                //                       .titleLarge
                //                       ?.fontSize),
                //             ),
                //             Text(selectedGame.empty
                //                 ? l10n(context).noGamesSelected
                //                 : selectedGame.displayName)
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                //)
              ],
            ))
      ],
    );
  }
}
