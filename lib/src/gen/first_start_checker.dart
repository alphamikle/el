import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;

import '../loader/config_loader.dart';
import '../tools/log.dart';
import 'generator_config.dart';

class FirstStartChecker {
  const FirstStartChecker({
    required this.config,
  });

  final GeneratorConfig config;

  void updatePubSpec() {
    final String packageName = config.packageName;
    final String packagePath = path.join(config.packagePath, packageName);
    String entrypointReplacement = 'sdk: flutter';
    RegExp entrypoint = RegExp(entrypointReplacement);

    final String pubspecPath = path.join(path.current, 'pubspec.yaml');
    final File pubspecFile = File(pubspecPath);

    if (pubspecFile.existsSync() == false) {
      log('pubspec.yaml has not found at $pubspecPath; Unable to automatically init $packageName package'
          .asRed());
      return;
    }

    final String pubspecContent = pubspecFile.readAsStringSync();

    if (pubspecContent.contains(packagePath)) {
      // Package already added to the pubspec previously
      return;
    }

    if (config.initPubspec == false) {
      log(
        'You have chosen not to initialize “$packageName” automatically. To use it you need to manually add the package to pubspec.yaml => dependencies, or you can enable the “$kUnitPubspec: true” parameter'
            .asYellow(),
      );
      return;
    }

    if (pubspecContent.contains(entrypoint) == false) {
      entrypointReplacement = 'dependencies:';
      entrypoint = RegExp(r'^dependencies:');
    }

    if (pubspecContent.contains(entrypoint) == false) {
      log('Not found "dependencies" section in pubspec.yaml. Unable to automatically init $packageName package'
          .asRed());
      return;
    }

    final String dependency = [
      entrypointReplacement,
      '',
      '''
  # *** Automatically added by easiest_localization ***
  # If you find it useful, please consider giving a ⭐ on GitHub: https://github.com/alphamikle/el
  # And leaving a 👍 on pub.dev: https://pub.dev/packages/easiest_localization
  # Your support is very important!''',
      '''
  $packageName:
    path: $packagePath
''',
    ].join('\n');

    final String newContent =
        pubspecContent.replaceFirst(entrypoint, dependency);

    pubspecFile.writeAsStringSync(newContent);

    log('$packageName package automatically added to pubspec'.asBlue());

    unawaited(_getDependencies());
  }

  Future<void> _getDependencies() async {
    final ProcessResult result = await Process.run('flutter', ['pub', 'get']);

    if (result.exitCode == 0) {
      log('Dependencies automatically updated. Enjoy the easiest_localization!'
          .asGreen());
    } else {
      log('Failed to run flutter pub get. Please, get dependencies by yourself to use ${config.packageName} package'
          .asRed());
    }
  }
}
