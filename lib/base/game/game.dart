class GameVersion {
  // late bool flattened;
  late bool snapshot;
  late String displayName;
  late String id;

  parseId() {
    // Versions like 22w13a, 21w16b, 1.16-pre3 and 1.13.1-rc2 are snapshots
    snapshot = RegExp(r'(\d\dw\d\d[abcdefg])|(1\.\d+(\.d+)?-(pre|rc)\d+)')
        .hasMatch(id);
  }

  GameVersion(this.id, {required this.displayName}) {
    parseId();
  }
}

class GameComponents {
  late String name;
  late String version;
  GameComponents(this.name, {required this.version});
}

class Game {
  late GameVersion version;
  late String path;
  List<GameComponents> components = [];

  Game({required this.version, required this.path, this.components = const []});

  launch() {
    // not to do
  }
}
