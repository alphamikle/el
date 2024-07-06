import 'package:easiest_localization/easiest_localization.dart';
import 'package:easiest_localization/src/loader/config_loader.dart';
import 'package:easiest_localization/src/loader/language_localization.dart';

void main(List<String> args) {
  final int start = DateTime.now().millisecondsSinceEpoch;
  GeneratorConfig config = ConfigLoader().load();
  if (args.contains('--format')) {
    config = config.copyWith(formatOutput: true);
  }
  final Generator generator = Generator(config);
  final (String, List<LanguageLocalization>) result = generator.generate();
  final double end = (DateTime.now().millisecondsSinceEpoch - start) / 1000;
  // ignore: avoid_print
  print(
    '[EASIEST_LOCALIZATION] Localizations generation completed in $end seconds with [${result.$2.map((LanguageLocalization it) => it.name).join(', ')}] locales',
  );
}
