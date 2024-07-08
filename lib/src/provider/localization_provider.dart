abstract interface class LocalizationProvider<L, M> {
  String get name;

  List<L> get supportedLocales;

  Future<M> fetchLocalization(L locale);

  bool canLoad(L locale);
}
