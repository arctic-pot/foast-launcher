import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: t(context, 'settings'),
      child: Column(
        children: const [
          Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
