![Logo](./assets/logo.png)

---

Easiest localization / **el** is the package, focused on providing the easiest and fastest way to localize your Flutter application with a type-safe generated code and full remote support in one jar.

Easiest localization is like [easy_localization](https://pub.dev/packages/easy_localization), but easier 😉, safer, better!

# Why easiest_localization?

- 🚀 Easiest translation for any language and country
- 🔌 Use as a source `json` or `yaml` files
- 💾 React and persist to locale changes in real time
- ⚡ Supports plural, gender, nesting, RTL locales and more
- ↩️ Fallback locale keys redirection
- ❤️ Ability to use without context access and still reactive support of language change
- 💻 Full code generation for localization files and keys with 100% type-safety
- 🛡️ Null safety and, which is more important - type safety! Your app just will not compile, if you missed some contents
- 🌐 Generated code supports [remote localization](https://pub.dev/packages/easiest_remote_localization) without any changes

If you are not happy with your localization library, want type-safety or incredible flexibility in naming of your strings - you just have to pay attention to `easiest_localization`

# Getting started

## 🔩 Installation

### Add easiest_localization package, as a normal dependency

```yaml
dependencies:
  easiest_localization: ^2.0.0
```

### Add `yaml` or `json` localization files under any assets folder, which is described in your `pubspec.yaml`:

```
/assets
├── /el_en.yaml
├── ...
├── /i18n
│   ├── /es.yaml
│   └── /ru.yaml
└── ...any other structures will be acceptable
```

Remember to add your assets in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/
    - assets/i18n/
```

The names of localization files must match the following RegExp:
`(\W)(el_)?(?<lang>[a-z]{2})[_-]?(?<country>[a-zA-Z]{2})?.(ya?ml|json)$`

That is, it must include at least a two-letter language code, and optionally, a country code separated by `-` or `_`:
- `el_en.yaml`
- `en.yaml`
- `en_US.json`
- `en-CA.yaml`

## ⚙️ Configuration

You can place it as a root key in your `pubspec.yaml` file to configure **el** very deeply. Here are the all options and their default values (if applicable):

```yaml
# ... Other pubspec' content

easiest_localization:
  # List of strings / patterns that will not be processed despite matching reg_exp
  # Empty list by default
  excluded: []
  
  # The name of the class containing the localization content
  class_name: LocalizationMessages
  
  # Description of the generated localization package
  description: Generated localization package
  
  # The version of the easiest_localization_version package used as a dependency
  # in the generated localization package;
  #
  # May be useful if you are using easiest_localization not from pub.dev
  # By default, it is the same version as in your application's pubspec.yaml file, and you don't need to change it
  # 
  # Examples: 2.0.0, "\n    path: ../../easiest_localization", "\n    git:\n      path: abc\n      url: abc\n      ref: 2.0.0"
  easiest_localization_version: <installed version>
  
  # Name of the generated localization package and the folder with it
  package_name: localization
  
  # Relative path to the generated localization package
  package_path: './'
  
  # Version of the generated localization package
  package_version: 1.0.0
  
  # An example of supported file names with a default RegExp: https://regex101.com/r/CALDhV/3
  #
  # !!! A mandatory requirement for RegExp: it must have named parameter (?<lang>[a-z]{2}) !!!
  reg_exp: "(\W)(el_)?(?<lang>[a-z]{2})[_-]?(?<country>[a-zA-Z]{2})?.(ya?ml|json)$"
  
  # The language code or full localization to be used as the content source,
  # defaulting to other languages if no fields are described.
  #
  # By default - null. This means that if one language has content for certain keys,
  # and another language does not have those keys at all - all values for those keys in
  # the other language will be empty.
  #
  # Examples: "en", "en_US", "en_CA", etc.
  primary_localization: null

  # Whether to apply code formatting to the generated localization package.
  #
  # If true - generation takes ~1 second longer. false by default
  format_output: false

  # This can be useful when you have multiple files for the same language.
  # For example - en, en_CA and en_UK. In this case, the main localization file - en,
  # will contain all the content. And each of the specific files - en_CA / en_UK can contain
  # only the content that should be different from the main file.
  #
  # However, for cloud storages, each of the language files must be fulfilled -
  # this is where merged files will be useful.
  #
  # In other words - the easiest way to support cloud localization is to use generated files
  # 
  # Examples:
  # - yaml - generated files will be in yaml format
  # - json - generated files will be in json format
  # - null - no files will be generated
  save_merged_files_as: yaml

  # Version of the generated content.
  # Will take effect only for merged generated files (yaml or json), which can help you to have several version of the remote content for old users
  #
  # Examples: "1", "v1", 1, anything else - String | int | double
  remote_version: null
```

## 🖨️ Code generation

Once you installed **el**, specified assets under `pubspec.yaml` and have, at least, one localization file at your assets folder - you able to generate type-safe localization code. To do that just run:

```bash
dart run easiest_localization [--format]
```

After that you will see the generated package with the default or your own name under specified folder. Then - you should install that package to your app. By default it would be like that:

```yaml
dependencies:
  localization:
    path: ./ # here should be a default path - "./" or [package_path] from the configuration
```

## ✍️ How to use

After generation and installation of generated package was complete - you able to use **el**. To do so you just need to add few variables to your `MaterialApp`:

```dart
import 'package:flutter/material.dart';
import 'package:localization/localization.dart'; // <- Import generated package

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          /// The first variable - [supportedLocales], which contains all the generated and fallback locales
          supportedLocales: supportedLocales,

          /// The second - [localizationsDelegates], which contains generated and default delegates for work of localizations in general
          localizationsDelegates: localizationsDelegates,

          /// Access to locale from the context               ⬇ ︎
          onGenerateTitle: (BuildContext context) => context.el.title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Builder(
            /// Or just by using a getter [el]                    ⬇ ︎
            builder: (BuildContext context) => MyHomePage(title: el.intro),
          ),
        );
      },
    );
  }
}
```

### 🛠️ Methods of using

As you saw above - **el** brings a lot of methods to retrieve localization content. They all splits into two groups: type safe and not. The first group - is recommended to use and the second - only if it is really necessary or if you want to retrieve localizations dynamically (by combining variables, for example), or...if you want to change the translation library at your app

```dart
typedef Greetings = String Function({required String username});

void showExample(BuildContext context) {
  /// Here is the most preferred way to use easiest_localization - type-safe and simple

  final String simple = el.appTitle;

  final Locale locale = Localizations.localeOf(context);
  final String withArgument = el.language(language: locale.languageCode, country: locale.countryCode ?? '');

  final String nested = el.mainScreen.todayDateFormat;

  /// This is a copy of the doc from [Intl.plural]'
  ///
  /// Selects the correct plural form from the provided alternatives.
  /// The [other] named argument is mandatory.
  /// The [precision] is the number of fractional digits that would be rendered
  /// when [howMany] is formatted. In some cases just knowing the numeric value
  /// of [howMany] itself is not enough, for example "1 mile" vs "1.00 miles"
  const int booksAmount = 3;
  final String nestedAndPlural = el.mainScreen.books.amountOfNew(booksAmount, precision: 0);

  final String genderWithArgument = el.author(Gender.female, name: 'Grace');

  /// Sometimes it can be useful to iterate content items as a list
  /// when there is a set of repetitive and structurally equal items.
  final List<Object> names = el.employees.contentList;

  /// -----------------------------------------------------------------------------------------------------------------------------

  /// Below are alternative ways to get the content.
  /// They are not very type-safe and it is the responsibility of the developer to ensure
  /// that a particular field turns out to be exactly what the developer expects.

  final String simpleWithTypeCast = el.getContent<String>('app_title'); // "Library App" OR an Exception, if the key is wrong

  final String nestedWithMultipleTypeCast = el.getContent<MainScreen>('main_screen').getContent<Greetings>('greetings')(username: 'Grace');

  final Object? dynamicV1 = el.employees[0]; // John Smith

  final Object? dynamicV2 = el['app_title']; // Library App

  final dynamic dynamicV3 = 'main_screen.greetings'.tr(); // String Function({required String username})

  final dynamic dynamicV4 = 'app_title'.el; // Library App

  final dynamic dynamicV5 = context.tr('app_title'); // Library App
}
```

## 📜 Localization content

For now you can use as a source only local `yaml` or `json` files. No remotes. Json example will be simpler, because of that let's take a look on a `yaml` localization file:

```yaml
# Simple string
source: Easiest Localization

app_title: Library App

# String with an argument
language: "Lang: ${language}"

# Nesting
main_screen:
  greetings: Hello, ${username}!
  books:
    add: Add Book
    
    # Pluralization
    amount_of_new:
      zero: There are no new books available at the moment :(
      one: There is ${howMany} new book available :)
      other: There are ${howMany} new books available :)
  today_date_format: MM/dd/yyyy
  
  # Multi-row strings (thanks to YAML)
  welcome: |
    # Welcome to our library!
    ---
    ## We are very happy to see you and would like you to enjoy reading our books.

# Gender-specific strings
author:
  male: ${name} - he is the author of that book!
  female: ${name} - she is the author of that book!
  other: ${name} - they are the author of that book!

privacy_policy_url: https://library.app/privacy_us.pdf

# Even invalid names of the keys will be correctly generated as a code, but still accessible by their real names with dynamic access
employees:
  "0": John Smith
  "1": Alice Johnson
  "2": Michael Brown
  "3": Emma Davis
  "4": William Taylor
```

### Pluralization

You, of course, able to pluralize the content. See an example above, near the comment "Pluralization".
And also, you are able to have any arguments (any String arguments) at your localization content. To make content pluralized, you should specify at least two keys:
- `one`
- `other`

All other arguments from that type of content are optional:
- `zero`
- `two`
- `few`
- `many`

```yaml
# en
amount_of_new:
  zero: There are no new books available at the moment :(
  one: There is ${howMany} new book available :)
  other: There are ${howMany} new books available :)
```

```yaml
# ru
amount_of_new:
  zero: В настоящий момент доступных новых книг нет :(
  one: В настоящий момент доступна ${howMany} новая книга :)
  two: В настоящий момент доступны ${howMany} новые книги :)
  few: В настоящий момент доступно ${howMany} новые книги :)
  many: В настоящий момент доступно ${howMany} новых книг :)
  other: В настоящий момент доступно ${howMany} новые книги :)
```

### Arguments

If you specify arguments inside localization strings (it doesn't matter where exactly this string is located - in a pluralization block, gender definition or in a simple string), the corresponding function will be generated instead of the usual variable. And you will have to pass the corresponding named argument to this function. For example:

```yaml
someKey: Hello, ${username}! What do you want to do ${day}? Will you go with me and ${friend} to the celebration? 
```

will generate a code, which be able to use as a function with next signature:

```dart
final String Function({required String username, required String day, required String friend}) someKey;
```

You can embed arguments to any type of content - described, pluralized and nested (inside namespaces). But there are some restrictions about argument names:

1. An argument named `howMany` will always be of type `num` if it is inside a pluralization block (specified inside one of the following keys: zero, one, two, few, many, other)
2. The argument called `precision` will always be of type `double` if it is inside a pluralization block (see above)
3. An argument called `gender` will always be of type `Gender` if it is specified inside the gender definition block (specified inside one of the following keys: female, male, other)

# Remote localization

## General Information

`easiest_localization` generates type-safe code, which makes it a pleasure to use. Additionally, you have the option to use remote localization sources from anywhere.

There are many different services for app localization, but the core purpose of any of them is to provide your application with a JSON document (whether via API or as a file—it's not so important).

The [easiest_remote_localization](https://pub.dev/packages/easiest_remote_localization) package allows you to retrieve JSON or YAML documents or files from any remote source and use the retrieved data as an argument for the constructor of the generated class, which serves as the representation of your localization code.

## Setup

The initialization process is extremely simple:

```dart
import 'package:easiest_localization/easiest_localization.dart';
import 'package:easiest_remote_localization/easiest_remote_localization.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Create remote providers - as many, as you want. But usually, you will need only one
  late final List<LocalizationProvider<LocalizationMessages>> remoteProviders = [
    RemoteLocalizationProvider<LocalizationMessages>(
      /// Set the cache duration
      /// During this time, the user will use the previously downloaded content
      cacheTTL: const Duration(hours: 3),

      /// If necessary - you can configure in detail how exactly the network request will be executed with Dio' BaseOptions
      options: BaseOptions(),
      sources: [
        /// Describe the “sources” for each of the supported languages
        ///
        /// Hint - since “source” is a very simple dataclass, it is quite easy to implement getting the sources themselves completely remotely.
        /// This way you can change not only the content of already supported languages, but also add new languages dynamically.
        RemoteSource(
          locale: Locale('en'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/en.json',
          type: SourceType.json,
        ),
        RemoteSource(
          locale: Locale('en', 'CA'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/en_CA.json',
          type: SourceType.json,
        ),
        RemoteSource(
          locale: Locale('es'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/es.json',
          type: SourceType.json,
        ),
        RemoteSource(
          locale: Locale('ru'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/ru.json',
          type: SourceType.json,
        ),
      ],

      /// Specify factory `.fromJson` from the generated class with localized content
      /// If you have not changed the settings, this line will look exactly the same
      /// If you have changed the `class_name` parameter - this will be `<class_name>.fromJson`
      factory: (RemoteSource source, Json content) => LocalizationMessages.fromJson(content),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => el.appTitle,

      /// Use localizationsDelegatesWithProviders(remoteProviders) instead of localizationsDelegates
      localizationsDelegates: localizationsDelegatesWithProviders(remoteProviders),

      /// And finally - use supportedLocalesWithProviders(remoteProviders) instead of supportedLocales
      supportedLocales: supportedLocalesWithProviders(remoteProviders),
      home: Home(),
    );
  }
}
```

> If you need 101% customization, you can use the low-level constructor `RemoteLocalizationProvider.raw` or implement your own `LocalizationProvider<LocalizationMessages>`

## Caching

You can set a cache lifespan (or disable caching entirely), ensuring that the user only downloads localization data once during a certain interval. This allows the use of remote content even when the user is offline. Caching is implemented using `shared_preferences`.

## Safety

Since your app will always have a local version of the localization, even if remote content cannot be loaded due to backend issues or the user has no internet and the cache is empty, the user will still see the localization from the local version.

If you’ve added a new language that is only available remotely and has never been downloaded, a fallback language defined by you, or the first language in the list, will be shown instead.

## Dynamic Language Expansion

As mentioned above, since you can store content for any language remotely, including new ones that are not yet in the app, this opens the possibility of adding new languages in real-time without needing to update the app.

## Best Practices

Maximum synergy can be achieved as follows: you develop the app and add or modify localized content. Simultaneously, comprehensive localization files will be generated if the corresponding setting is set to `save_merged_files_as: yaml` or `save_merged_files_as: json`. In this case, an additional `merged` folder will be created in the generated localization package, where you will find a list of JSON or YAML files that can be placed, for example, on your CDN. This process can be fully automated using CI/CD, allowing your users to receive the freshest content updates in real-time.

However, there are some limitations related to code generation: if you delete or change any keys in your local localization files, this will also affect the generated code and the files in the `merged` folder. As a result, users of older versions of your app will receive content from the remote source that may not contain the required fields (because they were deleted or the key names were changed). This, in turn, will cause an error when attempting to create localization classes from this modified content from the remote source. Ultimately, the user will see the local content. Therefore, when making changes that break backward compatibility, it makes sense to use versioning.

For this specific purpose, there is a `remote_version` parameter in the configuration. By default, it is set to `null`, which means that the generated (comprehensive) JSON/YAML files will be located at the path `.../generated_localization_package/merged/`. However, if you specify a version, for example, `2.0.0`, the files will be located at the following path: `.../generated_localization_package/merged/2.0.0/`, so each version of the localization will have its own set of files, and all of them will be accessible to your users.

---

Let me know if you need any further adjustments!


