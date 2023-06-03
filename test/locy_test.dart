import 'package:flutter_test/flutter_test.dart';
import 'package:locy/src/asset/assets_gen_loader.dart';
import 'package:locy/src/gen/generator_config.dart';

void main() {
  test('Test assets gen loader (default)', () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig());
    final result = loader.load();
    expect(result.length, 1);
  });

  test('Test assets gen loader (prefix = locale)', () {
    final AssetsGenLoader loader = AssetsGenLoader(const GeneratorConfig(prefix: 'locale'));
    final result = loader.load();
    expect(result.length, 1);
  });
}
