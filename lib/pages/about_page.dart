import 'package:flutter/material.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SubpageAppBar(
            title: 'About',
          ),
          Expanded(
              flex: 1,
              child: Text('NOT AN OFFICIAL MINECRAFT PRODUCT. '
                  'NOT APPROVED BY OR ASSOCIATED WITH MOJANG.'))
        ],
      ),
    );
  }
}
