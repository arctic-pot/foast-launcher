import 'package:flutter/material.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // do it later
        Expanded(flex: 1, child: Text('Microsoft')),
        Expanded(flex: 1, child: Text('Offline')),
        Expanded(flex: 1, child: Text('Authlib')),
      ],
    );
  }
}
