import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class ModsPage extends StatefulWidget {
  const ModsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ModsPageState();
}

class _ModsPageState extends State<ModsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SubpageAppBar(
            title: t(context, 'mods'),
          ),
          const Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
