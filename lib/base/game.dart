import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:path/path.dart' as p;

String getStandardPath() {
  if (Platform.isWindows) {
    return p.join('${Platform.environment['APPDATA']}', './.minecraft');
  }
  if (Platform.isMacOS) {
    return '~/Library/Application Support/minecraft';
  }
  if (Platform.isLinux) {
    return '~/.minecraft';
  }

  /// This should be NEVER executed
  throw Error();
}

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

class GameData with ChangeNotifier {
  Game _selectedGame =
      Game(GameVersion('1.16.5', displayName: '1.16.5'), path: 'path');
  bool _standardPath = true;
  Game get selected => _selectedGame;
  bool get standardPath => _standardPath;
  String get selectedPath => _standardPath ? getStandardPath() : './.minecraft';
  set standardPath(bool value) {
    _standardPath = value;
    notifyListeners();
  }

  set selected(Game value) {
    _selectedGame = value;
    notifyListeners();
  }
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
  final bool noJar;
  final bool empty;
  List<GameComponent> components = [];

  Game(this.version,
      {required this.path,
      this.noJar = false,
      this.components = const [],
      this.icon = GameIcon.grassBlock,
      this.empty = false});

  getInstalled(BuildContext context) {
    String stringComponents = components
        .map((component) => '${component.name} ${component.version}')
        .toList()
        .join(', ');
    if (stringComponents.isEmpty) {
      stringComponents = l10n(context).vanilla;
    }
    if (noJar) {
      return l10n(context).noJarVersion;
    }
    if (version.id == null) {
      return l10n(context).externalVersion;
    }
    return 'Minecraft ${version.id}\n$stringComponents';
  }

  get displayName => version.displayName;

  static List<Game> loadFromPath([String rootPath = './.minecraft']) {
    final Directory dir = Directory(p.join(rootPath, 'versions'));
    List<Game> games = dir.listSync(recursive: false).map((element) {
      try {
        final gamePath = element.path;

        /// Here we use the Windows path as an example
        /// C:\path\to\.minecraft\versions\versionName\1.16.5.jar
        ///                       dirName: ¯¯¯¯¯¯¯¯¯¯¯
        final dirName = element.path.split(Platform.pathSeparator).last;
        final manifestFile = File(p.join(gamePath, './.fstl'));
        final jsonFile = File(p.join(gamePath, './$dirName.json'));
        final jarFile = File(p.join(gamePath, './$dirName.jar'));
        // If json file or jar file doesn't exist, the version is invalid
        if (!jsonFile.existsSync()) {
          throw Error();
        }
        // If manifest is not exist, return unknown data
        if (!manifestFile.existsSync()) {
          return Game(GameVersion(null, displayName: dirName),
              path: gamePath, noJar: !jarFile.existsSync());
        }
        final manifest = jsonDecode(manifestFile.readAsLinesSync().join(''));
        return Game(GameVersion(manifest['id'], displayName: dirName),
            path: gamePath, noJar: !jarFile.existsSync());
      } catch (e) {
        return EmptyGame();
      }
    }).toList()
      ..retainWhere((element) => !element.empty);
    return games;
  }

  static Game generate(
      {required String id,
      required String displayName,
      required String path,
      required bool installed}) {
    return Game(GameVersion(id, displayName: displayName),
        path: path, noJar: !installed);
  }

  launch() {
    //\\//\\//\\//\\//\\//\\//
  }
}

class EmptyGame extends Game {
  EmptyGame() : super(GameVersion('', displayName: ''), path: '', empty: true);
}
