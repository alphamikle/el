String classFactoryBeginningTemplate({required String className}) {
  return '''
factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
''';
}

String classFactoryEndTemplate() {
  return '''
    );
  }''';
}
