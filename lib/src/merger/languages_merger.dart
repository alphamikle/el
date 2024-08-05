import 'dart:convert';
import 'dart:io';

import 'package:merger/merger.dart';
import 'package:path/path.dart';

import '../gen/generator_config.dart';
import '../loader/language_localization.dart';
import '../tools/extensions.dart';
import '../type/types.dart';

// en, ru, zh, etc.
typedef Language = String;
// US, UK, CA, etc.
typedef CountryCode = String;

class LanguagesMerger {
  const LanguagesMerger(this.config);

  final GeneratorConfig config;

  List<LanguageLocalization> merge(List<LanguageLocalization> languages) {
    final Map<Language, List<LanguageLocalization>> primaryLocalizationsParticles = {};
    final Map<Language, List<LanguageLocalization>> alternativeLocalizations = {};

    for (final LanguageLocalization localization in languages) {
      final Language lang = localization.language;

      if (localization.isPrimary) {
        if (primaryLocalizationsParticles.containsKey(lang) == false) {
          primaryLocalizationsParticles[lang] = [];
        }
        primaryLocalizationsParticles[lang]!.add(localization);
      } else {
        if (alternativeLocalizations.containsKey(lang) == false) {
          alternativeLocalizations[lang] = [];
        }
        alternativeLocalizations[lang]!.add(localization);
      }
    }

    final List<LanguageLocalization> response = [];
    final Map<Language, LanguageLocalization> primaryLocalizations = {};

    for (final MapEntry(key: language, value: localizationParticles) in primaryLocalizationsParticles.entries) {
      if (localizationParticles.isEmpty) {
        continue;
      }

      localizationParticles.sort(sizeSorter);

      LanguageLocalization primaryLocalization = localizationParticles.removeAt(0);

      for (final LanguageLocalization particle in localizationParticles) {
        primaryLocalization = primaryLocalization.copyWith(
          content: primaryLocalization.content.mergeWith(particle.content),
        );
      }

      response.add(primaryLocalization);
      primaryLocalizations[language] = primaryLocalization;
    }

    for (final MapEntry(key: language, value: countrySpecificLocalizations) in alternativeLocalizations.entries) {
      final LanguageLocalization? primaryLocalization = primaryLocalizations[language];

      if (primaryLocalization == null) {
        response.addAll(countrySpecificLocalizations);
      } else {
        final Map<CountryCode, List<LanguageLocalization>> localizationsByCountryCodes = {};

        for (final LanguageLocalization localization in countrySpecificLocalizations) {
          final String? country = localization.country;

          if (country == null) {
            throw Exception('Not found country code in the country-specific localization');
          }

          if (localizationsByCountryCodes.containsKey(country) == false) {
            localizationsByCountryCodes[country] = [];
          }

          localizationsByCountryCodes[country]!.add(localization);
        }

        final List<LanguageLocalization> effectiveCountrySpecificLocalizations = [];

        for (final MapEntry(key: country, value: localizationParticles) in localizationsByCountryCodes.entries) {
          if (localizationParticles.isEmpty) {
            continue;
          }

          localizationParticles.sort(sizeSorter);

          LanguageLocalization primaryLocalization = localizationParticles.removeAt(0);

          for (final LanguageLocalization particle in localizationParticles) {
            primaryLocalization = primaryLocalization.copyWith(
              content: primaryLocalization.content.mergeWith(particle.content),
            );
          }

          effectiveCountrySpecificLocalizations.add(primaryLocalization);
        }

        for (final LanguageLocalization localization in effectiveCountrySpecificLocalizations) {
          response.add(
            localization.copyWith(
              content: primaryLocalization.content.mergeWith(localization.content),
            ),
          );
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

    LanguageLocalization emptyScheme = scheme.empty();

    final String? primaryLocalizationCode = config.primaryLocalization;

    if (primaryLocalizationCode != null) {
      final LanguageLocalization? primaryLocalization = response.firstWhereOrNull(
        (LanguageLocalization it) {
          return it.name == primaryLocalizationCode || it.country == primaryLocalizationCode || it.language == primaryLocalizationCode;
        },
      );
      if (primaryLocalization == null) {
        // ignore: avoid_print
        print('The primary localization was defined as [$primaryLocalizationCode], but no matching localization file was found.');
      } else {
        emptyScheme = emptyScheme.copyWith(
          content: emptyScheme.content.mergeWith(primaryLocalization.content),
        );
      }
    }

    for (int i = 0; i < response.length; i++) {
      final LanguageLocalization localization = response[i];
      response[i] = localization.copyWith(
        content: emptyScheme.content.mergeWith(localization.content),
      );
    }

    if (config.saveMergedFiles != null) {
      _saveMergedFiles(config, response);
    }

    response.add(scheme);

    return response;
  }
}

int sizeSorter(LanguageLocalization a, LanguageLocalization b) => b.size.compareTo(a.size);

void _saveMergedFiles(GeneratorConfig config, List<LanguageLocalization> localizations) {
  final String outputPath = join(Directory.current.path, config.packagePath, config.packageName, 'merged');

  Directory(outputPath).createSync(recursive: true);

  for (final LanguageLocalization localization in localizations) {
    final String fileName = '${[localization.language, if (localization.country != null) localization.country].join('_')}.json';

    File(join(outputPath, fileName)).writeAsStringSync(jsonEncode(localization.content));
  }
}
