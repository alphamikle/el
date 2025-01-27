import '../locale/code_output.dart';
import '../template/imports_template.dart';
import 'extensions.dart';
import 'multi_entity.dart';

String factoryValueGenerator({
  required String rawName,
  String? jsonKey,
  Set<String> arguments = const {},
  bool withHowMany = false,
  bool nullable = false,
  MultiEntity? multiEntity,
}) {
  final bool hasArguments = arguments.isNotEmpty;
  String extraction = switch (multiEntity) {
    MultiEntity.list =>
      "(json[${qu(rawName)}] ?? json[${qu(rawName.clearMultiKey())}])",
    MultiEntity.map =>
      "(json[${qu(rawName)}] ?? json[${qu(rawName.clearMultiKey())}])",
    null => "json[${qu(rawName)}]",
  };
  extraction = [
    extraction,
    if (jsonKey != null) "['$jsonKey']",
  ].join();

  if (multiEntity == null && nullable) {
    return [
      extraction,
      ' == null || $extraction.toString().trim() == \'\' ? null : ',
      extraction,
      '.toString()',
      if (withHowMany) ".replaceAll(r'\${howMany}', howMany.toString())",
      for (final argument in arguments)
        ".replaceAll(r'\${$argument}', $argument)",
      if (hasArguments) ".replaceAll(_variableRegExp, '')",
    ].join();
  }

  return [
    if (multiEntity == MultiEntity.list) contentList,
    if (multiEntity == MultiEntity.map) contentMap,
    "($extraction",
    switch (multiEntity) {
      MultiEntity.list => " is List<Object?> ? $extraction : <Object?>[])",
      MultiEntity.map =>
        " is Map<String, Object?> ? $extraction : <String, Object?>{})",
      null => " ?? '').toString()",
    },
    if (withHowMany && multiEntity == null)
      ".replaceAll(r'\${howMany}', howMany.toString())",
    if (multiEntity == null)
      for (final argument in arguments)
        ".replaceAll(r'\${$argument}', $argument)",
    if (multiEntity == null && hasArguments) ".replaceAll(_variableRegExp, '')",
  ].join();
}
