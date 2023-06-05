import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:locy/src/gen/generator.dart';
import 'package:locy/src/gen/generator_config.dart';
import 'package:locy/src/loader/assets_gen_loader.dart';
import 'package:path/path.dart';

const String sdk = '>= 3.0.0 < 4.0.0';

void main() {
  test('Test assets gen loader (default)', () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(dartSdk: sdk, excludedPatterns: ['custom', 'schema']));
    final result = loader.load();
    expect(result.length, 1);
  });

  test('Test assets gen loader (prefix = locale)', () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(dartSdk: sdk, prefix: 'locale'));
    final result = loader.load();
    expect(result.length, 1);
  });

  test('Localization generation test', () {
    final Generator generator = Generator(const GeneratorConfig(dartSdk: sdk, excludedPatterns: ['custom', 'schema']));
    final String code = generator.generate();
    final String goldenResult = File(join(current, 'test', 'golden_result.dart')).readAsStringSync();
    expect(code, goldenResult);
  });
}
