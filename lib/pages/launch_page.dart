import 'package:flutter/material.dart';
import 'package:foast_launcher/pages/accounts_page.dart';
import 'package:foast_launcher/pages/games_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
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
                                label: const Text('Manage Version'),
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
                                label: const Text('Manage Account'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 80,
                          width: 250,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Launch',
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.fontSize),
                                  ),
                                  const Text('WIP'),
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
