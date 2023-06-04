import '../gen/generator_config.dart';

String assetsPubspecTemplate(GeneratorConfig config) => '''
name: ${config.packageName}
description: ${config.packageDescription}
version: ${config.packageVersion}

environment:
  sdk: "${config.dartSdk}"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
''';
