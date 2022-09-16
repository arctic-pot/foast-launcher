import 'package:flutter/material.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:foast_launcher/pages/body_wrapper.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _SettingsPageState();
// }

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildGroup(
      {required String title, List<Widget> children = const []}) {
    return Builder(
      builder: (context) => SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: children,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [_buildGroup(title: 'Data')],
      ),
    );
  }
}
