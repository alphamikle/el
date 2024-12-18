import 'dart:convert';
import 'dart:io';

import 'package:merger/merger.dart';
import 'package:path/path.dart';
import 'package:yaml_writer/yaml_writer.dart';

import '../gen/generator_config.dart';
import '../loader/language_localization.dart';
import '../locale/localization_unit.dart';
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

        for (final MapEntry(value: localizationParticles) in localizationsByCountryCodes.entries) {
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

    if (config.saveMergedFilesAs != null) {
      final bool saveAsJson = config.saveMergedFilesAs == 'json';

      _saveMergedFiles(config, response, saveAsJson: saveAsJson);
    }

    response.add(scheme);

    return response;
  }
}

int sizeSorter(LanguageLocalization a, LanguageLocalization b) => b.size.compareTo(a.size);

void _saveMergedFiles(GeneratorConfig config, List<LanguageLocalization> localizations, {bool saveAsJson = false}) {
  final String outputPath = join(
    Directory.current.path,
    config.packagePath,
    config.packageName,
    'merged',
    config.version?.trim(),
  );

  Directory(outputPath).createSync(recursive: true);

  for (final LanguageLocalization localization in localizations) {
    final String fileName = '${[localization.language, if (localization.country != null) localization.country].join('_')}.${saveAsJson ? 'json' : 'yaml'}';
    final Json clearJson = _clearJson(localization.content);

    String contentToSave = '';

    if (saveAsJson) {
      contentToSave = jsonEncode(clearJson);
    } else {
      final YamlWriter yamlWriter = YamlWriter();
      final String yamlDoc = yamlWriter.write(clearJson);
      contentToSave = yamlDoc.toString();
    }

    File(join(outputPath, fileName)).writeAsStringSync(contentToSave);
  }
}

Json _clearJson(dynamic json) {
  final Json result = {};

  if (json is! DJson) {
    return result;
  }

  for (final MapEntry(:dynamic key, :dynamic value) in json.entries) {
    final String id = key.toString();
    final UnitType type = UnitType.fromValue(value);

    final _ = switch (type) {
      UnitType.gender => result[id] = _clearGenderValue(value),
      UnitType.plural => result[id] = _clearPluralValue(value),
      UnitType.string => result[id] = value,
      UnitType.namespace => result[id] = _clearJson(value),
      UnitType.unknown => result[id] = value,
    };
  }
  return result;
}

Json _clearPluralValue(DJson json) {
  final String? zero = _nullIfEmpty(json.get('zero'));
  final String? one = _nullIfEmpty(json.get('one'));
  final String? two = _nullIfEmpty(json.get('two'));
  final String? few = _nullIfEmpty(json.get('few'));
  final String? many = _nullIfEmpty(json.get('many'));
  final String? other = _nullIfEmpty(json.get('other'));

  return {
    if (zero != null) 'zero': zero,
    if (one != null) 'one': one,
    if (two != null) 'two': two,
    if (few != null) 'few': few,
    if (many != null) 'many': many,
    'other': other ?? '',
  };
}

Json _clearGenderValue(DJson json) {
  final String? male = _nullIfEmpty(json.get('male'));
  final String? female = _nullIfEmpty(json.get('female'));
  final String? other = _nullIfEmpty(json.get('other'));
  return {
    if (male != null) 'male': male,
    if (female != null) 'female': female,
    'other': other ?? '',
  };
}

String? _nullIfEmpty(String? value) {
  if (value == null || value.trim() == '') {
    return null;
  }
  return value;
}
