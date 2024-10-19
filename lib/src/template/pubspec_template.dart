import '../gen/generator_config.dart';

String assetsPubspecTemplate(GeneratorConfig config) => '''
# *** Automatically added by easiest_localization ***
# If you find it useful, please consider giving a ⭐ on GitHub: https://github.com/alphamikle/el
# And leaving a 👍 on pub.dev: https://pub.dev/packages/easiest_localization
# Your support is very important!
name: ${config.packageName}
description: ${config.packageDescription}
publish_to: none
version: ${config.packageVersion}${config.version == null ? '' : '+${config.version}'}

environment:
  sdk: "${config.dartSdk}"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  easiest_localization: ${config.easiestLocalizationVersion}
''';
