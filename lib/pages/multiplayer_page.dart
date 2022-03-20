import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';

class MultiplayerPage extends StatelessWidget {
  const MultiplayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: t(context, 'multiplayer'),
      child: Column(
        children: const [Text('WIP')],
      ),
    );
  }
}
