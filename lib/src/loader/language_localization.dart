/// Represents the contents of a single localization file, with content presented in the single language
class LanguageLocalization {
  const LanguageLocalization({
    required this.language,
    required this.content,
  });

  final String language;
  final Map<String, dynamic> content;
}
