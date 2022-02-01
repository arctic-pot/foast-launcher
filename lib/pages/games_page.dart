import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:foast_launcher/pages/app_bar.dart';
import 'package:foast_launcher/pages/download_page.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final double _width = 285;
  int _radioGroupValue = 0;

  void _handleChangePath(int? newValue) {
    setState(() {
      _radioGroupValue = newValue ?? 0;
    });
  }

  _buildSubtitle(String text) {
    return Container(
      width: _width,
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SubpageAppBar(
            title: t(context, 'games'),
          ),
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: _width,
                      child: Column(
                        children: [
                          _buildSubtitle(t(context, 'game_path')),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              RadioListTile(
                                title: Text(t(context, 'path_current')),
                                value: 0,
                                groupValue: _radioGroupValue,
                                onChanged: _handleChangePath,
                              ),
                              RadioListTile(
                                title: Text(t(context, 'path_official')),
                                value: 1,
                                groupValue: _radioGroupValue,
                                onChanged: _handleChangePath,
                              ),
                            ],
                          ),
                          _buildSubtitle(t(context, 'add_or_import')),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: Text(t(context, 'install_version')),
                                leading: const Icon(Icons.download_rounded),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const DownloadPage()));
                                },
                              ),
                              ListTile(
                                title: Text(t(context, 'import_modpack')),
                                leading: const Icon(Icons.add_circle_rounded),
                                enabled: false,
                              ),
                            ],
                          ),
                        ],
                      )),
                  const VerticalDivider(width: 1),
                  Expanded(
                      child: GridView.count(
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    padding: const EdgeInsets.all(10.0),
                    crossAxisCount: 4,
                    childAspectRatio: 0.9,
                    controller: ScrollController(),
                    children: [
                      RadioListTile(value: 1, groupValue: 2, onChanged: (a) {}),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(
                            children: [
                              Radio(value: 1, groupValue: 1, onChanged: (i) {}),
                              Text(
                                'Title',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'MC Version',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                'Patches',
                                style: Theme.of(context).textTheme.caption,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
