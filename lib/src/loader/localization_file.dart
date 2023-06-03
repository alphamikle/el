class LocalizationFile {
  const LocalizationFile({
    required this.language,
    required this.content,
  });

  final String language;
  final Map<String, dynamic> content;
}
