import 'dart:ui' show Locale;

/// An interface for implementation your own localization provider - remote, local, whatever
abstract interface class LocalizationProvider<M> {
  /// Getter, mostly useful for logging purposes
  String get name;

  /// Explicit list of supported, by that provider, locales
  List<Locale> get supportedLocales;

  /// Method for loading localization for a specific locale
  Future<M> fetchLocalization(Locale locale);

  /// Fast checker for ability to load locale content
  bool canLoad(Locale locale);
}
