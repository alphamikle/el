import 'extensions.dart';

typedef NameConverter = String Function(String value);

enum NamingStrategy {
  // Name will be the same, as variable
  plain,

  // camelCase
  camel,

  // PascalCase
  pascal,

  // snake_case
  snake,

  // SCREAMING_SNAKE_CASE
  screamingSnake,

  // kebab-case
  kebab,

  // Train-Case
  train,

  // dot.case
  dot;

  factory NamingStrategy.fromString(String value) {
    const Map<String, NamingStrategy> namesMap = {
      'plain': NamingStrategy.plain,
      'camel': NamingStrategy.camel,
      'pascal': NamingStrategy.pascal,
      'snake': NamingStrategy.snake,
      'screamingSnake': NamingStrategy.screamingSnake,
      'kebab': NamingStrategy.kebab,
      'train': NamingStrategy.train,
      'dot': NamingStrategy.dot,
    };
    final NamingStrategy? strategy = namesMap[value];
    if (strategy == null) {
      throw Exception('Not supported Naming Strategy: "$value". Supported values: ${NamingStrategy.values.map((NamingStrategy it) => it.name)}');
    }
    return strategy;
  }
}

String _transformer({
  required String input,
  String joiner = '',
  bool capitalizeFirst = false,
  bool allowPrivate = true,
  bool capitalizeAll = false,
  bool lowerAll = false,
}) {
  final List<String> words = _split(input);
  if (words.isEmpty) {
    return '';
  }

  final bool isPrivate = input._isPrivate;
  bool capitalized = false;

  String? charMapper(int index, String char) {
    if (capitalized == false && _isSmallChar(char)) {
      capitalized = true;
      return char.toUpperCase();
    }
    return char;
  }

  String? wordMapper(int index, String word) {
    if (word == '_') {
      return null;
    }
    capitalized = false;
    final String mapped = word.toLowerCase().mapIndexed(charMapper);
    capitalized = false;
    if (lowerAll) {
      return mapped.toLowerCase();
    }
    if (capitalizeAll) {
      return mapped.toUpperCase();
    }
    if (capitalizeFirst) {
      return mapped;
    }
    return (index == 0 || isPrivate && index == 1) ? mapped.toLowerCase() : mapped;
  }

  return '${(isPrivate && allowPrivate ? '_' : '')}${words.mapIndexed(wordMapper).join(joiner)}';
}

String toCamelCase(String input) => _transformer(input: input);

String toPascalCase(String input) => _transformer(input: input, capitalizeFirst: true);

String toSnakeCase(String input) => _transformer(input: input, lowerAll: true, joiner: '_');

String toScreamingSnakeCase(String input) => _transformer(input: input, capitalizeAll: true, joiner: '_');

String toKebabCase(String input) => _transformer(input: input, lowerAll: true, joiner: '-');

String toTrainCase(String input) => _transformer(input: input, capitalizeFirst: true, joiner: '-');

String toDotCase(String input) => _transformer(input: input, lowerAll: true, joiner: '.');

String toSomeCase(String input, NamingStrategy strategy) {
  final String converted = switch (strategy) {
    NamingStrategy.plain => input,
    NamingStrategy.camel => toCamelCase(input),
    NamingStrategy.pascal => toPascalCase(input),
    NamingStrategy.snake => toSnakeCase(input),
    NamingStrategy.screamingSnake => toScreamingSnakeCase(input),
    NamingStrategy.kebab => toKebabCase(input),
    NamingStrategy.train => toTrainCase(input),
    NamingStrategy.dot => toDotCase(input),
  };
  return converted;
}

bool _isNumber(String? char) {
  if (char == null) {
    return false;
  }

  return char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
}

bool _isUpperCase(String? char) {
  if (char == null) {
    return false;
  }

  return char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90;
}

bool _isSmallChar(String? char) {
  if (char == null) {
    return false;
  }

  return char.codeUnitAt(0) >= 97 && char.codeUnitAt(0) <= 122;
}

bool _isDollar(String? char) {
  if (char == null) {
    return false;
  }

  return char == r'$';
}

bool _isUnderscore(String? char) {
  if (char == null) {
    return false;
  }

  return char == '_';
}

List<String> _split(String input) {
  final List<String> output = [];
  final List<String> word = [];

  void addWord() {
    output.add(word.join());
    word.clear();
  }

  for (int i = 0; i < input.length; i++) {
    final bool isFirst = i == 0;

    final String char = input[i];
    final bool isNumber = _isNumber(char);
    final bool isUpperCase = _isUpperCase(char);
    final bool isSmallChar = _isSmallChar(char);
    final bool isDollar = _isDollar(char);
    final bool isUnderscore = _isUnderscore(char);

    final String? prevChar = word.isEmpty ? null : word.last;
    final bool isPrevNumber = _isNumber(prevChar);
    final bool isPrevUpper = _isUpperCase(prevChar);
    final bool isPrevSmall = _isSmallChar(prevChar);
    final bool isPrevDollar = _isDollar(prevChar);
    final bool isPrevUnderscore = _isUnderscore(prevChar);

    final bool wordIsEmpty = word.isEmpty;
    final bool wordIsNotEmpty = word.isNotEmpty;

    /// ? _privateVariable
    if (isUnderscore && isFirst) {
      output.add(char);
      continue;
    }

    /// ? skipping__several___underscores
    if (isUnderscore && isPrevUnderscore) {
      continue;
    }

    /// ? underscore_as_a_divider_between_chars
    if (isUnderscore && wordIsNotEmpty) {
      addWord();
      continue;
    }

    /// ? when word = 123... and char is 0-9, then adding char to the word
    if (isNumber && (wordIsNotEmpty && isPrevNumber || wordIsEmpty)) {
      word.add(char);
      continue;
    }

    /// ? when word is not a sequence of numbers and char is 0-9, then adding word and after that - adding char to the word
    if (isNumber && wordIsNotEmpty && isPrevNumber == false) {
      addWord();
      word.add(char);
      continue;
    }

    /// ? when word is abc || 123 || A-Z, then adding word and after - adding char to the word
    if (isUpperCase && wordIsNotEmpty && (isPrevSmall || isPrevNumber)) {
      addWord();
      word.add(char);
      continue;
    }

    /// ? when word is [$] - adding char to the word
    if (isUpperCase && word.length == 1 && isPrevDollar) {
      word.add(char);
      continue;
    }

    /// ? when word is empty - adding char to the word
    if (isUpperCase && wordIsEmpty) {
      word.add(char);
      continue;
    }

    /// ? when word is AAA..., also - just adding char to the word
    if (isUpperCase && isPrevUpper) {
      word.add(char);
      continue;
    }

    /// ? always adding any new small chars to the word if the last is not a number
    if (isSmallChar && isPrevNumber == false) {
      word.add(char);
      continue;
    }

    /// ? always adding any new small chars to the word if the last is not a number
    if (isSmallChar && isPrevNumber) {
      addWord();
      word.add(char);
      continue;
    }

    if (isDollar && (wordIsEmpty || isPrevDollar)) {
      word.add(char);
      continue;
    }

    /// ? $ can be a divider between small symbols, but it always stick to the next non-number symbol
    /// ? $smallValue => [$small, Value]; $small$value => [$small, $value]; $small123$456value => [$small, 123, $, 456, value]
    if (isDollar && wordIsNotEmpty && isPrevDollar == false) {
      addWord();
      word.add(char);
      continue;
    }
  }

  if (word.isNotEmpty) {
    addWord();
  }
  return output;
}

final Map<String, List<String>> _collisionsCache = {};

extension ExtendedConvertableCodeName on String {
  String get asCamelCase => toCamelCase(this);

  String get asPascalCase => toPascalCase(this);

  String get asSnakeCase => toSnakeCase(this);

  String get asScreamingSnakeCase => toScreamingSnakeCase(this);

  String get asKebabCase => toKebabCase(this);

  String get asTrainCase => toTrainCase(this);

  String get asDotCase => toDotCase(this);

  String get clear {
    final RegExp clearingRegExp = RegExp(r'[^A-Za-z0-9_]');
    final RegExp severalSnakesRegExp = RegExp(r'_+');
    final RegExp privateRegExp = RegExp(r'^_');

    final String clearString = replaceAll(clearingRegExp, '_').replaceAll(severalSnakesRegExp, '_').replaceFirst(privateRegExp, '');

    return clearString;
  }

  String asClearCamelCase(String className) {
    String clearString = clear.asCamelCase;
    if (RegExp(r'^\d+').hasMatch(clearString)) {
      clearString = 'n$clearString';
    }

    final String key = '$className:$clearString';

    if (_collisionsCache.containsKey(key) == false) {
      _collisionsCache[key] = [this];
    } else {
      if (_collisionsCache[key]!.contains(this) == false) {
        _collisionsCache[key]!.add(this);
      }
    }

    final int collisionIndex = _collisionsCache[key]!.indexOf(this);

    if (collisionIndex > 0) {
      return '$clearString$collisionIndex';
    }

    return clearString;
  }

  bool get _isPrivate => startsWith('_');
}
