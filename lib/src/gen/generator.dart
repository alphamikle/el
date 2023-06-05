import '../loader/assets_gen_loader.dart';
import '../loader/language_localization.dart';
import 'delegate_generator.dart';
import 'generator_config.dart';
import 'localization_file_interface_generator.dart';
import 'localization_file_values_generator.dart';
import 'package_saver.dart';

class Generator {
  Generator(this.config);

  final GeneratorConfig config;

  String generate() {
    final List<LanguageLocalization> localizations = AssetsGenLoader(config).load();
    final String interfaceCode = LocalizationFileInterfaceGenerator(config: config, localizations: localizations).generate();
    final String valuesCode = LocalizationFileValuesGenerator(config: config, localizations: localizations).generate();
    final String delegateCode = DelegateGenerator(config: config, localizations: localizations).generate();
    final String code = [
      interfaceCode,
      valuesCode,
      delegateCode,
    ].join('\n');
    return PackageSaver(config).save(code);
  }
}
