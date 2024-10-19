import '../../template/class_factory_template.dart';
import '../../tools/code_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput namespacedUnitToInterface(NamespacedUnit unit, {bool useThisKeyword = true}) {
  final List<String> constructorParents = [];

  for (int i = 0; i < unit.parents.length; i++) {
    constructorParents.add(capitalize(unit.parents[i]));
  }

  final String variableName = unit.fieldName;
  final String constructorName = [...constructorParents, capitalize(unit.fieldName)].join();

  final List<CodeOutput> childrenCodeWithoutThisKeyword = [];
  final List<CodeOutput> childrenCodeWithThisKeyword = [];

  final List<String> dynamicContent = [
    'Map<String, Object> get _content => {',
  ];

  for (final MapEntry(:value) in unit.value.entries) {
    childrenCodeWithoutThisKeyword.add(localizationUnitToInterface(value, useThisKeyword: false));
    childrenCodeWithThisKeyword.add(localizationUnitToInterface(value));
    dynamicContent.add("r'''${value.rawName}''': ${value.fieldName},");
  }

  dynamicContent.addAll([
    '};',
    '''
T getContent<T>(String key) {
  final Object? value = _content[key];
  if (value is T) {
    return value;
  }
  throw ArgumentError('Not found content for the key \$key with type \$T');
}

Map<String, Object> get content => _content;

List<Object> get contentList => _content.values.toList();

int get length => _content.length;

Object? operator [](Object? key) {
  final Object? value = _content[key];
  if (value == null && key is String) {
    final int? index = int.tryParse(key);
    if (index == null || index >= contentList.length || index < 0) {
      return null;
    }

    return contentList[index];
  }
  return value;
}
''',
  ]);

  final List<String> classArgumentCode = [
    '${useThisKeyword ? 'required this.' : ''}$variableName${useThisKeyword ? ',' : ':'}${useThisKeyword ? '' : ' const $constructorName('}',
    if (useThisKeyword == false) ...childrenCodeWithoutThisKeyword.map((CodeOutput code) => code.classArgumentCode),
    if (useThisKeyword == false) '),'
  ];

  final String classBodyCode = '''
final $constructorName $variableName;
''';

  final List<String> externalCode = [
    'class $constructorName {',
    'const $constructorName ({',
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.classArgumentCode),
    if (childrenCodeWithThisKeyword.isEmpty) 'String? stub,',
    '});',
    classFactoryBeginningTemplate(className: constructorName),
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.factoryArgumentCode ?? ''),
    classFactoryEndTemplate(),
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.classBodyCode),
    ...dynamicContent,
    '}',
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.externalCode),
  ];

  return CodeOutput(
    classArgumentCode: classArgumentCode.join('\n'),
    classBodyCode: classBodyCode,
    externalCode: externalCode.join('\n'),
    factoryArgumentCode: '${unit.fieldName}: $constructorName.fromJson((json[${qu(unit.rawName)}] as Map).cast<String, dynamic>()),',
  );
}
