import 'package:merger/merger.dart';

import '../gen/generator_config.dart';
import '../loader/language_localization.dart';
import '../type/types.dart';

// en, ru, zh, etc.
typedef Language = String;

class LanguagesMerger {
  const LanguagesMerger(this.config);

  final GeneratorConfig config;

  List<LanguageLocalization> merge(List<LanguageLocalization> languages) {
    final Map<Language, LanguageLocalization> primaryLocalizations = {};
    final Map<Language, List<LanguageLocalization>> alternativeLocalizations = {};

    for (final LanguageLocalization localization in languages) {
      final String lang = localization.language;

      if (alternativeLocalizations.containsKey(lang) == false) {
        alternativeLocalizations[lang] = [];
      }

      if (localization.isPrimary) {
        primaryLocalizations[lang] = localization;
      } else {
        alternativeLocalizations[lang]!.add(localization);
      }
    }

    final List<LanguageLocalization> response = [];

    response.addAll(primaryLocalizations.values);

    for (final MapEntry(key: key, value: value) in alternativeLocalizations.entries) {
      final LanguageLocalization? primaryLocalization = primaryLocalizations[key];
      if (primaryLocalization == null) {
        response.addAll(value);
      } else {
        for (final LanguageLocalization localization in value) {
          final LanguageLocalization mergedLocalization = localization.copyWith(
            content: mergeMaps(primaryLocalization.content, localization.content),
          );
          response.add(mergedLocalization);
        }
      }
    }

    int maxSize = 0;
    late LanguageLocalization scheme;

    for (final LanguageLocalization localization in response) {
      if (localization.size > maxSize) {
        maxSize = localization.size;
        scheme = localization;
      }
    }

    scheme = LanguageLocalization(
      language: kScheme,
      country: null,
      content: scheme.content,
    );

    for (final LanguageLocalization localization in response) {
      scheme = scheme.copyWith(
        content: mergeMaps(scheme.content, localization.content, joinStrings: true),
      );
    }

    for (int i = 0; i < response.length; i++) {
      final LanguageLocalization localization = response[i];
      response[i] = localization.copyWith(
        content: scheme.content.mergeWith(localization.content),
      );
    }

    response.add(scheme);

    return response;
  }
}
