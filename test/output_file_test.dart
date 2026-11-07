import 'dart:io';

import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:easiest_localization/src/gen/package_saver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  test('Code is saved to output_file without generating a package', () {
    final Directory root = Directory.systemTemp.createTempSync('el_output_file');
    addTearDown(() => root.deleteSync(recursive: true));

    final String outputFile = path.join(root.path, 'lib', 'generated', 'localization.gen.dart');
    final GeneratorConfig config = GeneratorConfig(
      packagePath: root.path,
      outputFile: outputFile,
      initPubspec: false,
    );

    final String output = PackageSaver(config).save('const int value = 1;');

    expect(output, 'const int value = 1;\n');
    expect(File(outputFile).readAsStringSync(), output);
    expect(Directory(path.join(root.path, 'localization')).existsSync(), false);
  });

  test('Code is saved to a generated package by default', () {
    final Directory root = Directory.systemTemp.createTempSync('el_package');
    addTearDown(() => root.deleteSync(recursive: true));

    PackageSaver(GeneratorConfig(packagePath: root.path, dartSdk: '^3.6.0')).save('const int value = 1;');

    expect(File(path.join(root.path, 'localization', 'lib', 'localization.dart')).existsSync(), true);
    expect(File(path.join(root.path, 'localization', 'pubspec.yaml')).existsSync(), true);
  });
}
