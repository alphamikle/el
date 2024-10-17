import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;

import '../loader/config_loader.dart';
import '../loader/pubspec_loader.dart';
import '../tools/debouncer.dart';
import '../tools/log.dart';
import 'generator_config.dart';

typedef GeneratorFunction = void Function(GeneratorConfig config, int startedTimestamp);

class Watcher {
  Watcher({
    required this.generator,
    required this.config,
  });

  final GeneratorFunction generator;

  GeneratorConfig config;

  final Map<String, StreamSubscription<FileSystemEvent>> _subscriptions = {};

  void start() {
    final List<String> assetsPaths = PubspecLoader(config: config).loadAssetsPaths();
    final String pubspecPath = path.join(path.current, 'pubspec.yaml');
    final File pubspecFile = File(pubspecPath);

    if (pubspecFile.existsSync() == false) {
      log('pubspec.yaml was not found to init file watcher'.asRed());
      return;
    }

    final Stream<FileSystemEvent> eventsStream = pubspecFile.watch();

    unawaited(_subscriptions[pubspecPath]?.cancel());
    _subscriptions[pubspecPath] = eventsStream.listen(_pubspecWatcher);

    for (final String path in assetsPaths) {
      unawaited(_subscriptions[path]?.cancel());
      _subscriptions.remove(path);

      if (FileSystemEntity.isDirectorySync(path)) {
        _subscriptions[path] = Directory(path).watch().listen(_dirWatcher);
      } else if (FileSystemEntity.isFileSync(path)) {
        _subscriptions[path] = File(path).watch().listen(_fileWatcher);
      }
    }
  }

  void _dirWatcher(FileSystemEvent event) {
    if (event.isDirectory == false) {
      final PubspecLoader pubspecLoader = PubspecLoader(config: config);
      final File file = File(event.path);

      if (file.existsSync() && pubspecLoader.isSupportedFile(file) == false) {
        return;
      }
    }

    Debouncer.run(
      'dir_watcher',
      () {
        final int now = DateTime.now().millisecondsSinceEpoch;
        generator(config, now);
      },
    );
  }

  void _fileWatcher(FileSystemEvent event) => _dirWatcher(event);

  void _pubspecWatcher(FileSystemEvent event) {
    log('Pubspec file changed'.asGreen());

    final GeneratorConfig newConfig = ConfigLoader().load();
    config = newConfig.copyWith(watch: config.watch);
    _reInit();

    final int now = DateTime.now().millisecondsSinceEpoch;
    generator(config, now);
  }

  void _reInit() {
    for (final MapEntry(:value) in _subscriptions.entries) {
      unawaited(value.cancel());
    }
    _subscriptions.clear();
    start();
  }
}
