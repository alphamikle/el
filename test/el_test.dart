import 'dart:io';

import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

import '../bin/easiest_localization.dart' as bin;

void main() {
  test('Localization generation: E2E Test', () async {
    bin.main(['--format']);

    await Process.run('dart', ['format', '.'], runInShell: true);

    final String output = File(
            path.join(path.current, 'localization', 'lib', 'localization.dart'))
        .readAsStringSync();
    final String goldenResult =
        File(path.join(path.current, 'test', 'golden_result.dart'))
            .readAsStringSync();

    expect(output, equals(goldenResult));
  });

  test('Custom settings: yaml', () {
    const String easiestLocalizationVersion = '2.0.0-beta';
    const String dartSdk = '>=3.5.0 <4.0.0';
    const String localizationsClassName = 'ElLocalization';
    const String packageDescription = 'Custom description';
    const String packageVersion = '1.0.1';
    const String remoteVersion = '1.0.5';

    bin.generate(
      GeneratorConfig(
        saveMergedFilesAs: 'yaml',
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

    final String dartOutput = File(path.join(path.current, 'custom_path',
            'custom_localization', 'lib', 'localization.dart'))
        .readAsStringSync();

    final String mergedOutput = File(path.join(path.current, 'custom_path',
            'custom_localization', 'merged', remoteVersion, 'en_CA.yaml'))
        .readAsStringSync();
    final String mergedGoldenResult =
        File(path.join(path.current, 'test', 'golden_en_ca_merged_result.yaml'))
            .readAsStringSync();

    final String generatedPubSpec = File(path.join(
            path.current, 'custom_path', 'custom_localization', 'pubspec.yaml'))
        .readAsStringSync();

    expect(mergedOutput, equals(mergedGoldenResult));

    const List<String> needToContain = [
      easiestLocalizationVersion,
      dartSdk,
      packageDescription,
      packageVersion,
    ];

    for (final String param in needToContain) {
      expect(generatedPubSpec.contains(param), equals(true),
          reason: 'Not found param: $param');
    }

    expect(dartOutput.contains(localizationsClassName), equals(true));
  });
}
