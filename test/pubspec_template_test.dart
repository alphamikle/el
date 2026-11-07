import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:easiest_localization/src/template/pubspec_template.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('Generated pubspec has no resolution by default', () {
    final YamlMap pubspec = loadYaml(assetsPubspecTemplate(const GeneratorConfig(dartSdk: '^3.6.0'))) as YamlMap;
    expect(pubspec.containsKey('resolution'), false);
  });

  test('Generated pubspec inherits workspace resolution', () {
    final YamlMap pubspec = loadYaml(assetsPubspecTemplate(const GeneratorConfig(dartSdk: '^3.6.0', resolution: 'workspace'))) as YamlMap;
    expect(pubspec['resolution'], 'workspace');
    expect((pubspec['environment'] as YamlMap)['sdk'], '^3.6.0');
  });
}
