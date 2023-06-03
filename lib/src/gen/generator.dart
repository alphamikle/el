import '../asset/assets_gen_loader.dart';
import '../loader/localization_file.dart';
import 'generator_config.dart';

class Generator {
  Generator(this.config);

  final GeneratorConfig config;

  void generate() {
    final List<LocalizationFile> localizations = AssetsGenLoader(config).load();
  }
}
