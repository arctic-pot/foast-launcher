import 'package:flutter/material.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SubpageAppBar(
            title: 'Download',
          ),
          Expanded(flex: 1, child: Text('WIP'))
        ],
      ),
    );
  }
}
