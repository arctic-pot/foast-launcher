import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:foast_launcher/i18n/localizations.dart';
import 'package:path/path.dart' as p;

enum GameIcon {
  grassBlock,
  furnace,
  cobblestone,
  endStone,
  redstoneBlock,
  goldBlock,
  diamondBlock,
  bedrock,
  chest,
  anvil,
}

class GameVersion {
  // late bool flattened;
  final String displayName;
  final String? id;

  GameVersion(this.id, {required this.displayName});
}

class GameComponent {
  final String name;
  final String version;
  GameComponent(this.name, {required this.version});
}

class Game {
  final GameVersion version;
  final String path;
  final GameIcon icon;
  final bool empty;
  List<GameComponent> components = [];

  Game(this.version,
      {required this.path,
      this.components = const [],
      this.icon = GameIcon.grassBlock,
      this.empty = false});

  getInstalled(BuildContext context) {
    String stringComponents = components
        .map((component) => '${component.name} ${component.version}')
        .toList()
        .join(', ');
    if (stringComponents.isEmpty) {
      stringComponents = t(context, 'vanilla');
    }
    if (version.id == null) {
      return '${t(context, 'external_version')}\n';
    }
    return 'Minecraft ${version.id}\n$stringComponents';
  }

  static Future<List<Game>> loadFromPath(
      [String rootPath = './.minecraft']) async {
    final Directory dir = Directory(p.join(rootPath, './versions'));
    List<Game> games = dir.listSync(recursive: false).map((element) {
      try {
        final gamePath = element.path;

        /// Here we use the Windows path as an example
        /// C:\path\to\.minecraft\versions\versionName\1.16.5.jar
        ///                       dirName: ¯¯¯¯¯¯¯¯¯¯¯
        final dirName = element.path.split(Platform.pathSeparator).last;
        final manifestFile = File(p.join(gamePath, './$dirName.fstl'));
        final jsonFile = File(p.join(gamePath, './$dirName.json'));
        final jarFile = File(p.join(gamePath, './$dirName.jar'));
        // If json file or jar file doesn't exist, the version is invalid
        if (!(jsonFile.existsSync() && jarFile.existsSync())) {
          throw Error();
        }
        // If manifest is not exist, return unknown data
        if (!manifestFile.existsSync()) {
          return Game(GameVersion(null, displayName: dirName), path: gamePath);
        }
        final manifest = jsonDecode(manifestFile.readAsLinesSync().join(''));
        return Game(GameVersion(manifest['id'], displayName: dirName),
            path: gamePath);
      } catch (e) {
        return Game(GameVersion('', displayName: ''), path: '', empty: true);
      }
    }).toList()
      ..retainWhere((element) => !element.empty);
    return games;
  }

  launch() {
    //\\//\\//\\//\\//\\//\\//
  }
}
