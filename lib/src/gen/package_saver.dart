import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import '../template/pubspec_template.dart';
import '../tools/fixer.dart';
import '../tools/log.dart';
import 'generator_config.dart';

class PackageSaver {
  PackageSaver(this.config);

  final GeneratorConfig config;

  String save(String code) {
    final String? outputFile = config.outputFile;
    if (outputFile != null) {
      return _write(File(outputFile), code);
    }

    final String absolutePackagePath = path.join(config.packagePath, config.packageName);

    final Directory dir = Directory(absolutePackagePath);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    final String libPath = path.join(absolutePackagePath, 'lib');
    final Directory libDir = Directory(libPath);
    if (!libDir.existsSync()) {
      libDir.createSync(recursive: true);
    }
    final String result = _write(File(path.join(libPath, 'localization.dart')), code);
    final File pubspecFile = File(path.join(absolutePackagePath, 'pubspec.yaml'));
    pubspecFile.writeAsStringSync(assetsPubspecTemplate(config));
    return result;
  }

  String _write(File libFile, String code) {
    libFile.parent.createSync(recursive: true);
    final DartFormatter formatter = DartFormatter(pageWidth: 160, languageVersion: DartFormatter.latestShortStyleLanguageVersion);
    String formattedCode = code;

    try {
      formattedCode = formatter.format(code);
    } catch (error, stackTrace) {
      log('Some error was happened when formatting of the code performed\n$error\n$stackTrace');
    }

    libFile.writeAsStringSync(formattedCode);
    if (config.formatOutput) {
      fixPackage(libFile.path);
    }
    return File(libFile.path).readAsStringSync();
  }
}
