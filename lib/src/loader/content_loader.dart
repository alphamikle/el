import 'dart:async';

import 'language_localization.dart';

abstract interface class ContentLoader {
  FutureOr<List<LanguageLocalization>> load();
}
