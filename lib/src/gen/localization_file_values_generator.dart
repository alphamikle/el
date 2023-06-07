import '../loader/language_localization.dart';
import '../locale/localization_unit.dart';
import '../template/language_value_beginning_template.dart';
import '../tools/code_tools.dart';
import '../tools/localization_tools.dart';
import 'generator_config.dart';

class LocalizationFileValuesGenerator {
  LocalizationFileValuesGenerator({
    required this.config,
    required this.localizations,
  });

  final GeneratorConfig config;
  final List<LanguageLocalization> localizations;

  final List<String> constructorArgumentsCode = [];

  String generate() {
    final List<String> languagesCode = [];
    if (localizations.isEmpty) {
      throw ArgumentError('localizations argument should not be empty');
    }
    for (final LanguageLocalization languageLocalization in localizations) {
      final List<String> code = [
        languageValueBeginningTemplate(lang: languageLocalization.language, className: config.localizationsClassName),
      ];

      for (final MapEntry(:String key, :Object value) in languageLocalization.content.entries) {
        final LocalizationUnit localizationUnit = localizeValue(key, value);
        code.add(localizationUnitToValue(localizationUnit).classArgumentCode);
      }
      code.addAll([
        ');',
      ]);
      languagesCode.add(code.join('\n'));
    }

    return languagesCode.join('\n');
  }
}
