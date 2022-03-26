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
    return SubPageScaffold(
      title: l10n(context).accounts,
      child: Column(
        children: const [
          Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
