import 'dart:io';

import 'package:yaml/yaml.dart';

final RegExp _pubspecRegExp = RegExp(r'pubspec.ya?ml$');

class PubspecLoader {
  YamlMap load() {
    final List<File> files = Directory.current.listSync().whereType<File>().toList();
    final File pubspec = files.firstWhere((File it) => it.path.contains(_pubspecRegExp), orElse: () => throw Exception('Not found pubspec.yaml file'));
    final YamlMap pubspecContent = loadYaml(pubspec.readAsStringSync()) as YamlMap;
    return pubspecContent;
  }
}
