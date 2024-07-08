import '../gen/generator_config.dart';

String assetsPubspecTemplate(GeneratorConfig config) => '''
# Generated with easiest_localization: https://pub.dev/packages/easiest_localization
name: ${config.packageName}
description: ${config.packageDescription}
publish_to: none
version: ${config.packageVersion}

environment:
  sdk: "${config.dartSdk}"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  easiest_localization: ${config.easiestLocalizationVersion}
''';
