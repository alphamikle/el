import 'package:easiest_localization/src/gen/first_start_checker.dart';
import 'package:easiest_localization/src/gen/generator.dart';
import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:easiest_localization/src/gen/watcher.dart';
import 'package:easiest_localization/src/loader/config_loader.dart';
import 'package:easiest_localization/src/loader/language_localization.dart';
import 'package:easiest_localization/src/tools/log.dart';
import 'package:intl/intl.dart';

String _locales(int howMany) => Intl.plural(
      howMany,
      name: 'locales',
      one: 'locale',
      other: 'locales',
    );

void main(List<String> args) => runner(args);

void runner(List<String> args, [GeneratorConfig? configOverride]) {
  final int start = DateTime.now().millisecondsSinceEpoch;
  GeneratorConfig config = configOverride ?? ConfigLoader().load();

  if (args.contains('--format')) {
    config = config.copyWith(formatOutput: true);
  }

  if (args.contains('--no-format')) {
    config = config.copyWith(formatOutput: false);
  }

  if (args.contains('--watch')) {
    config = config.copyWith(watch: true);
  }

  if (args.contains('--no-watch')) {
    config = config.copyWith(watch: false);
  }

  if (args.contains('--init')) {
    config = config.copyWith(initPubspec: true);
  }

  if (args.contains('--no-init')) {
    config = config.copyWith(initPubspec: false);
  }

  generate(config, start);

  if (config.watch) {
    log('Watch mode active...'.asGreen());
    _watch(config);
  }
}

void generate(GeneratorConfig config, int startedTimestamp) {
  try {
    final Generator generator = Generator(config);
    final (String, List<LanguageLocalization>) result = generator.generate();
    final int end = (DateTime.now().millisecondsSinceEpoch - startedTimestamp);

    final List<String> locales = result.$2.map((LanguageLocalization it) => it.name).toList(growable: false);

    log('Localizations generation completed in ${end}ms with [${locales.join(', ')}] ${_locales(locales.length)}'.asBlue());

    FirstStartChecker(config: config).updatePubSpec();
  } catch (error, stackTrace) {
    log(error.toString().asRed());
    log(stackTrace.toString());
  }
}

void _watch(GeneratorConfig initialConfig) {
  final Watcher watcher = Watcher(generator: generate, config: initialConfig);
  watcher.start();
}
