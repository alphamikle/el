import 'package:easiest_localization/easiest_localization.dart';
import 'package:easiest_localization/src/loader/config_loader.dart';
import 'package:easiest_localization/src/loader/language_localization.dart';

void main() {
  final int start = DateTime.now().millisecondsSinceEpoch;
  final GeneratorConfig config = ConfigLoader().load();
  final Generator generator = Generator(config);
  final (String, List<LanguageLocalization>) result = generator.generate();
  final double end = (DateTime.now().millisecondsSinceEpoch - start) / 1000;
  // ignore: avoid_print
  print(
    '[EASIEST_LOCALIZATION] Localizations generation completed in $end seconds with [${result.$2.map((LanguageLocalization it) => it.language).join(', ')}] locales',
  );
}
