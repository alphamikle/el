const String qt = "'''";

class CodeOutput {
  const CodeOutput({
    required this.classArgumentCode,
    required this.classBodyCode,
    required this.externalCode,
    this.factoryArgumentCode,
  });

  final String classArgumentCode;
  final String classBodyCode;
  final String externalCode;
  final String? factoryArgumentCode;
}
