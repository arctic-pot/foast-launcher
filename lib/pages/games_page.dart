import 'package:flutter/material.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SubpageAppBar(
            title: 'Games',
          ),
          Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
