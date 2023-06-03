import 'dart:async';

import 'localization_file.dart';

abstract interface class ContentLoader {
  FutureOr<List<LocalizationFile>> load();
}
