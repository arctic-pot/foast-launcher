import 'package:flutter/material.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class OnlinePlayingPage extends StatefulWidget {
  const OnlinePlayingPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OnlinePlayingPageState();
}

class _OnlinePlayingPageState extends State<OnlinePlayingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SubpageAppBar(
            title: 'Online Playing',
          ),
          Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
