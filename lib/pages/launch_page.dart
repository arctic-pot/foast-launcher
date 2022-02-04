import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/accounts_page.dart';
import 'package:foast_launcher/pages/games_page.dart';
import 'package:foast_launcher/base/game.dart' show GameData;
import 'package:provider/provider.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

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
                    bottom: 40,
                    right: 40,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              width: 180,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const GamesPage()));
                                },
                                icon: const Icon(Icons.widgets_rounded),
                                label: Text(AppLocalizations.of(context)
                                    .getTranslation('manage_versions')),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 35,
                              width: 180,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountsPage()));
                                },
                                icon: const Icon(Icons.account_circle_rounded),
                                label: Text(AppLocalizations.of(context)
                                    .getTranslation('manage_accounts')),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 80,
                          width: 250,
                          child: ElevatedButton(
                              onPressed: selectedGame.empty ? null : () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    t(context, 'launch'),
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.fontSize),
                                  ),
                                  Text(selectedGame.empty
                                      ? t(context, 'no_games_selected')
                                      : selectedGame.displayName)
                                ],
                              )),
                        ),
                      ],
                    ))
              ],
            ))
      ],
    );
  }
}
