import 'dart:io';

import 'package:easiest_localization/src/gen/generator.dart';
import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:easiest_localization/src/loader/assets_gen_loader.dart';
import 'package:easiest_localization/src/loader/language_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

const String sdk = '>= 3.0.0 < 4.0.0';

void main() {
  test('Test assets gen loader (default)', () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(dartSdk: sdk));
    final List<LanguageLocalization> result = loader.load();
    expect(result.length, 3);
  });

  test('Test assets gen loader (prefix = locale)', () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(dartSdk: sdk, namespace: 'locale'));
    final List<LanguageLocalization> result = loader.load();
    expect(result.length, 4);
  });

  test('Localization generation', () {
    final Generator generator = Generator(const GeneratorConfig(dartSdk: sdk));
    final (String, List<LanguageLocalization>) result = generator.generate();
    final String goldenResult = File(join(current, 'test', 'golden_result.dart')).readAsStringSync();
    expect(result.$1, goldenResult);
  });
}
