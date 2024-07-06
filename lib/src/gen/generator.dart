import '../loader/assets_gen_loader.dart';
import '../loader/language_localization.dart';
import '../merger/languages_merger.dart';
import 'delegate_generator.dart';
import 'generator_config.dart';
import 'localization_file_interface_generator.dart';
import 'localization_file_values_generator.dart';
import 'package_saver.dart';

/// Entry point for code generation purposes
class Generator {
  Generator(this.config);

  /// Generation config
  final GeneratorConfig config;

  /// Generate and return localization dart code
  (String, List<LanguageLocalization>) generate() {
    List<LanguageLocalization> localizations = AssetsGenLoader(config).load();
    localizations = LanguagesMerger(config).merge(localizations);
    final String interfaceCode = LocalizationFileInterfaceGenerator(config: config, localizations: localizations).generate();
    final String valuesCode = LocalizationFileValuesGenerator(config: config, localizations: localizations).generate();
    final String delegateCode = DelegateGenerator(config: config, localizations: localizations).generate();
    final String code = [
      interfaceCode,
      valuesCode,
      delegateCode,
    ].join('\n');
    return (PackageSaver(config).save(code), localizations);
  }
}
