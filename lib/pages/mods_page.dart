import 'package:flutter/material.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';

class ModsPage extends StatefulWidget {
  const ModsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ModsPageState();
}

class _ModsPageState extends State<ModsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(flex: 1, child: Text('WIP'))
      ],
    );
  }
}
