import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SubpageAppBar(
            title: t(context, 'accounts'),
          ),
          const Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
