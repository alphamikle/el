import '../asset/assets_gen_loader.dart';
import '../loader/language_localization.dart';
import '../locale/localization_file_interface_generator.dart';
import 'generator_config.dart';

class Generator {
  Generator(this.config);

  final GeneratorConfig config;

  void generate() {
    final List<LanguageLocalization> localizations =
        AssetsGenLoader(config).load();
    final String localizationCode = LocalizationFileInterfaceGenerator(
            config: config, localizations: localizations)
        .generate();
  }
}
