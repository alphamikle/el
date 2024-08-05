import 'dart:ui' show Locale;

abstract interface class LocalizationProvider<M> {
  String get name;

  List<Locale> get supportedLocales;

  Future<M> fetchLocalization(Locale locale);

  bool canLoad(Locale locale);
}
