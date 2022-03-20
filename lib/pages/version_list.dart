import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/game.dart';

class VersionList extends StatelessWidget {
  final void Function(Game)? onSelect;
  final double height;
  final String path;
  final bool showSelected;
  final List<Game>? games;

  const VersionList(
      {Key? key,
      this.onSelect,
      this.path='',
        this.games,
      this.showSelected = false,
      this.height = double.maxFinite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView(
        children: (games ?? []).map((version) {
          return ListTile(
            title: Text(version.displayName),
            subtitle: Text(version.getInstalled(context)),
            onTap: () {
              poof(_) {}
              (onSelect ?? poof)(version);
            },
            selected: showSelected &&
                context.watch<GameData>().selected.displayName ==
                    version.displayName,
          );
        }).toList(),
      ),
    );
  }
}
