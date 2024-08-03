import 'dart:io';

import 'package:easiest_localization/src/gen/generator.dart';
import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:easiest_localization/src/loader/assets_gen_loader.dart';
import 'package:easiest_localization/src/loader/language_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

const String sdk = '>= 3.0.0 < 4.0.0';

// TODO(alphamikle):  Fix skipped tests
void main() {
  test('Test assets gen loader (default)', skip: true, () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(dartSdk: sdk));
    final List<LanguageLocalization> result = loader.load();
    expect(result.length, 6);
  });

  test('Test assets gen loader (prefix = locale)', skip: true, () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(dartSdk: sdk));
    final List<LanguageLocalization> result = loader.load();
    expect(result.length, 4);
  });

  test('Localization generation', () {
    final Generator generator = Generator(
      const GeneratorConfig(
        dartSdk: sdk,
        excludedPatterns: [
          'localizely_example',
        ],
      ),
    );
    final (String, List<LanguageLocalization>) result = generator.generate();
    final String goldenResult = File(join(current, 'test', 'golden_result.dart')).readAsStringSync();
    expect(result.$1, goldenResult);
  });
}
