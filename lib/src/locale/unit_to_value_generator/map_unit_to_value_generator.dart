import 'dart:convert';

import '../../template/imports_template.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/multi_entity.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput mapUnitToValue(MapUnit unit) {
  return CodeOutput(
    classArgumentCode: "${unit.fieldName}: $contentMap(${jsonEncode(unit.value)}),",
    initializerList: null,
    classBodyCode: '',
    factoryArgumentCode: _factoryCode(unit),
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
