import 'dart:io';

import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

import '../bin/easiest_localization.dart' as bin;

const bool preparingMode = bool.fromEnvironment('PREPARE');

void main() {
  test('${preparingMode ? 'Preparing: ' : ''}Comprehensive code-generation tests', () async {
    bin.main(['--format']);

    final String output = '${File(path.join(path.current, 'localization', 'lib', 'localization.dart')).readAsStringSync()}\n';
    final File goldenFile = File(path.join(path.current, 'test', 'golden_result.dart.txt'));
    final String goldenResult = goldenFile.readAsStringSync();

    if (preparingMode) {
      goldenFile.writeAsStringSync(output);
      expect(output.isNotEmpty, true);
    } else {
      expect(output, equals(goldenResult));
    }
  });

  test('${preparingMode ? 'Preparing: ' : ''}Code-generation with custom settings', () {
    const String easiestLocalizationVersion = '3.0.0-alpha';
    const String dartSdk = '>=3.6.0 <4.0.0';
    const String localizationsClassName = 'ElLocalization';
    const String packageDescription = 'Custom description';
    const String packageVersion = '1.0.1';
    const String remoteVersion = '1.0.5';

    bin.generate(
      GeneratorConfig(
        saveMergedFilesAs: 'json',
        easiestLocalizationVersion: easiestLocalizationVersion,
        dartSdk: dartSdk,
        formatOutput: true,
        localizationsClassName: localizationsClassName,
        packageDescription: packageDescription,
        packageName: 'custom_localization',
        packagePath: './custom_path',
        primaryLocalization: 'en',
        packageVersion: packageVersion,
        version: remoteVersion,
        initPubspec: false,
      ),
      DateTime.now().millisecondsSinceEpoch,
    );

    final String dartOutput = '${File(path.join(path.current, 'custom_path', 'custom_localization', 'lib', 'localization.dart')).readAsStringSync()}\n';

    final String mergedOutput =
        '${File(path.join(path.current, 'custom_path', 'custom_localization', 'merged', remoteVersion, 'en_CA.json')).readAsStringSync()}\n';
    final File mergedGoldenFile = File(path.join(path.current, 'test', 'golden_en_ca_merged_result.json'));
    final String mergedGoldenResult = mergedGoldenFile.readAsStringSync();

    if (preparingMode) {
      mergedGoldenFile.writeAsStringSync(mergedOutput);
      expect(mergedOutput.isNotEmpty, true);
    } else {
      expect(mergedOutput, equals(mergedGoldenResult));
    }

    final String generatedPubSpec = File(path.join(path.current, 'custom_path', 'custom_localization', 'pubspec.yaml')).readAsStringSync();

    const List<String> needToContain = [
      easiestLocalizationVersion,
      dartSdk,
      packageDescription,
      packageVersion,
    ];

    Directory(path.join(path.current, 'custom_path')).deleteSync(recursive: true);

    for (final String param in needToContain) {
      expect(generatedPubSpec.contains(param), equals(true), reason: 'Not found param: $param');
    }

    expect(dartOutput.contains(localizationsClassName), equals(true));
  });
}
