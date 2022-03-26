import 'package:flutter/material.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: l10n(context).server,
      child: Column(
        children: const [
          Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
