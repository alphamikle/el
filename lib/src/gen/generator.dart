import '../asset/assets_gen_loader.dart';
import '../loader/language_localization.dart';
import 'generator_config.dart';
import 'localization_file_interface_generator.dart';
import 'localization_file_values_generator.dart';

class Generator {
  Generator(this.config);

  final GeneratorConfig config;

  void generate() {
    final List<LanguageLocalization> localizations = AssetsGenLoader(config).load();
    final String interfaceCode = LocalizationFileInterfaceGenerator(config: config, localizations: localizations).generate();
    final String valuesCode = LocalizationFileValuesGenerator(config: config, localizations: localizations).generate();

    final String result = '$interfaceCode\n$valuesCode';
    print(1);
  }
}
