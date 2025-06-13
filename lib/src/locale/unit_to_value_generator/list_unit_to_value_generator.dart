import 'dart:convert';

import '../../template/imports_template.dart';
import '../../tools/extensions.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/multi_entity.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput listUnitToValue(ListUnit unit) {
  return CodeOutput(
    classArgumentCode: "${unit.fieldName}: $contentList(${clearDollars(jsonEncode(unit.value.toJson()))}),",
    initializerList: null,
    classBodyCode: '',
    factoryArgumentCode: _factoryCode(unit),
    externalCode: '',
  );
}

String _factoryCode(ListUnit unit) {
  final String fieldName = unit.fieldName;
  final String rawName = unit.rawName;

  return '''
$fieldName: ${factoryValueGenerator(rawName: rawName, arguments: {}, multiEntity: MultiEntity.list)},
''';
}
