const String kDefaultPrefix = 'intl';
const String kDefaultLanguagePattern = r'[A-Za-z]{2}';
const String kDefaultLocalizationClassName = 'LocalizationMessages';

class GeneratorConfig {
  const GeneratorConfig({
    this.prefix = kDefaultPrefix,
    this.languagePattern = kDefaultLanguagePattern,
    this.localizationsClassName = kDefaultLocalizationClassName,
    RegExp? regExp,
  }) : _regExp = regExp;

  final String prefix;
  final Pattern languagePattern;
  final String localizationsClassName;

  final RegExp? _regExp;

  RegExp get regExp => _regExp ?? RegExp('(?<lang>$languagePattern)_(?<pattern>$prefix).ya?ml\$');
}
