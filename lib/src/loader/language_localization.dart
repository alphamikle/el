import '../tools/emptier.dart';
import '../tools/extensions.dart';

/// Represents the contents of a single localization file, with content presented in the single language
class LanguageLocalization {
  factory LanguageLocalization({
    required String language,
    required String? country,
    required Map<String, dynamic> content,
  }) {
    return LanguageLocalization._(
      language: language,
      country: country,
      content: content,
      size: content.deepSize,
    );
  }

  const LanguageLocalization._({
    required this.language,
    required this.country,
    required this.content,
    required this.size,
  });

  final String language;
  final String? country;
  final Map<String, dynamic> content;
  final int size;

  bool get isPrimary => country == null;

  String get name => [
        language,
        if (country != null) '_',
        if (country != null) country,
      ].join();

  String get localeAsString => "Locale('${language.toLowerCase()}'${country == null ? '' : ", '${country!.toUpperCase()}'"})";

  LanguageLocalization copyWith({
    String? language,
    String? country,
    Map<String, dynamic>? content,
  }) {
    return LanguageLocalization(
      language: language ?? this.language,
      country: country ?? this.country,
      content: content ?? this.content,
    );
  }

  LanguageLocalization empty() {
    return LanguageLocalization(
      language: language,
      country: country,
      content: content.empty(),
    );
  }

  @override
  String toString() {
    return 'LanguageLocalization{name: $name, size: $size, content: $content}';
  }
}
