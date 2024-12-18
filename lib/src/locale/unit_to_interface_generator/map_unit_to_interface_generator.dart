import 'dart:convert';

import '../../template/imports_template.dart';
import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/multi_entity.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput mapUnitToInterface(MapUnit unit, {bool useThisKeyword = true}) {
  final bool hasArgs = hasArguments(unit.schemaValue);

  if (hasArgs) {
    throw Exception('Entity of type MapUnit can not have any arguments in the content');
  }

  String parentClassName = unit.parents.map(capitalize).join();

  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $contentMap(${jsonEncode(unit.value)})'},",
    factoryArgumentCode: _factoryCode(unit),
    classBodyCode: 'final $contentMap ${unit.fieldName};',
    externalCode: '',
  );
}

String _factoryCode(MapUnit unit) {
  final String fieldName = unit.fieldName;
  final String rawName = unit.rawName;

  return '''
$fieldName: ${factoryValueGenerator(rawName: rawName, arguments: {}, multiEntity: MultiEntity.map)},
''';
}
