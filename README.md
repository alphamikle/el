![Logo](./assets/logo.png)

---

Easiest localization (or **el**) is the ideological successor to the [yalo](https://pub.dev/packages/yalo) package, focused on providing the easiest and fastest way to localize your Flutter application

# Why easiest_localization?

- 🚀 Easiest translation for any language
- 🔌 Use as a source `json` or `yaml` files
- 💾 React and persist to locale changes
- ⚡ Supports plural, gender, nesting, RTL locales and more
- ↩️ Fallback locale keys redirection
- ❤️ Extension methods on `BuildContext` or, even, you can use **el** without `context` at all!
- 💻 Code generation for localization files and keys
- 🛡️ Null safety and, which is more important - type safety! Your app just will not compile, if you missed some contents

If you are not happy with your language pack, want type-safety or incredible flexibility in naming of your strings - you just have to pay attention to `easiest_localization`

# Getting started

## 🔩 Installation

```yaml
dev_dependencies:
  easiest_localization: <last_version>
```

Just put `yaml` or `json` localization filed under any assets folder, which is described in your `pubspec.yaml`:

```
/assets
├── /en_intl.yaml
├── ...
├── /translations
│   ├── /en.yaml
│   └── /pt.yaml
└── ...any other structure will be acceptable
```

Don't forget to describe your assets in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/
    # or / and
    - assets/translations/
    # or any folder, which you will use to store a translations
```
## ⚙️ Configuration

You can place it as a root key in your `pubspec.yaml` file to configure **el** very deeply. Or do not, if you want to use all the default settings. Just remember, that default pattern of localization file will be next:

```yaml
/**/.*[A-Za-z]{2}(_intl)?.(ya?ml|json)
# ** - can be any folder or child folder of the folder or deeper, which is described as your asset in pubspec.yaml
# [A-Za-z]{2} - language code, like "en", "fr", "pt"
# ya?ml|json - you can store it in json or yaml files
# Acceptable default examples:
# /assets/en.yaml
# /assets/tr/pt.json
# /assets/i18n/zh_intl.json
# /assets/localizations/localization_fr.yaml
```

```yaml
easiest_localization:
  # Default value
  namespace: intl
  # Default value
  language_prefix: "[A-Za-z]{2}"
  # By default - is empty / null
  excluded: []
  # Default name of output class
  class_name: LocalizationMessages
  # Default description of generated package
  description: Some description for generated package
  # Default name of generated package
  package_name: localization
  # Default path to generated package - the root of your project, under which will be created folder <package_name> (localization - by default)
  package_path: ./
  # Default version of generated package
  package_version: 1.0.0
  # Instead of using <namespace> and <language_prefix> params, you can define your own reg_exp to help el determine your localization files
  # Only one requirement applies to that regexp - it should contain at least one named argument <lang>
  # Like ".*translation.*(?<lang>.{2})" - will match on any json / yaml file under any folder with substring "translation" or if file will contain that substring
  reg_exp: "(?<lang>[A-Za-z]{2})_(?<pattern>intl).(ya?ml|json)$"
  # Will run "dart fix --apply" to generated package to make it perfect, but consumes a lot of time (100ms - without and about 5-7 seconds with it)
  format_output: false
  # The map of fallback languages. It works on next way:
  # fallback_locales:
  #   <missed_language>: <existed_fallback_language>
  # Wildcard '*" means, that existed fallback will be such for any missed locale
  # If you will not specify that parameter, then - the first founded locale will be used instead of missed
  fallback_locales:
    fr: en # for french locale will be used english
    it: pt # for italian locale will be user portuguese
    '*': zh # for all another missed locales will be used chinese
```

## 🖨️ Code generation

One you installed **el**, specified assets under `pubspec.yaml` and have, at least, one localization file at your assets folder - you able to generate type-safe localization code. To do that just run:

```bash
dart run easiest_localization
```

After that you will see the generated package with the default or your own name under specified folder. Then - you should install that package to your app. By default it would be like that:

```yaml
dependencies:
  localization:
    path: ./ # here should be the default or your <package_path>
```

## ✍️ How to use (example)

After generation and installation of generated package was complete - you able to use **el**. To do so you just need to add few variables to your `MaterialApp`:

```dart
import 'package:flutter/material.dart';
import 'package:localization/lib.dart'; // <- Import generated package

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              /// Equals to el.pages.home.counter(_counter)
              el.getContent<Pages>('pages').getContent<PagesHome>('home').getContent('counter')(_counter),
            ),
            Text('greetings2'.tr()(username: 'Alex')),
            Text(tr('greetings3.home')(username: 'Alex')),
            Text(context.tr('intro')),
          ]
              .map(
                (Widget child) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: child,
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,

        /// Equals to el.pages.home.incrementButton.title
        tooltip: el['pages']['home']['incrementButton']['title'],
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 🛠️ Methods of using

As you saw above - **el** brings a lot of methods to retrieve localization content. They all splits into two groups: type safe and not. The first group - is recommended to use and the second - only if it is really necessary or if you want to retrieve localizations dynamically (by combining variables, for example), or...if you want to change the translation library at your app

#### 🛡 Type safe

```dart
/// Simple value
Messages.of(context).title; // Easiest localization app
context.el.title;
Messages.el.title;
el.title;

/// Pluralized value
Messages.of(context).cow(5); // There are 5 cows
context.el.cow(5);
Messages.el.cow(5);
el.cow(5);

/// Namespaced value
Messages.of(context).views.home.description; // Home - is the main screen of the app
context.el.views.home.description;
Messages.el.views.home.description;
el.views.home.description;

/// Value with arguments (fully type-safe with IntelliSense suggestions from the IDE)
Messages.of(context).views.intro.greetings(username: 'Jack'); // Hello, Jack!
context.el.views.intro.greetings(username: 'Jack');
Messages.el.views.intro.greetings(username: 'Jack');
el.views.intro.greetings(username: 'Jack');

/// With arguments and pluralization and namespaces (also - fully type-safe)
el.views.settings.deleteAccount(14, username: 'Jack'); // Jack, your account will be deleted in 14 days.
```

#### 🦆 Dynamic

From string

```dart
/// Simple value
'title'.el; // Easiest localization app
'title'.tr();
tr('title');
context.tr('title');

/// Pluralized value
'cow'.el(5); // There are 5 cows
'title'.tr(5);
tr('title')(5);
context.tr('title')(5);

/// Namespaced value
'views.home.description'.el; // Home - is the main screen of the app
'views.home.description'.tr();
tr('views.home.description');
context.tr('views.home.description');

/// Value with arguments
'views.intro.greetings'.el(username: 'Jack');
'views.intro.greetings'.tr()(username: 'Jack');
tr('views.intro.greetings')(username: 'Jack');
context.tr('views.intro.greetings')(username: 'Jack');
```

From **el**


```dart
/// Simple value
el['title']; // Easiest localization app
el.getContent<String>('title');

/// Pluralized value
el['cow'](5); // There are 5 cows
el.getContent('cow')(5);

/// Namespaced value
el['views']['home']['description']; // Home - is the main screen of the app
el.getContent<Views>('views').getContent<ViewsHome>('home').getContent<String>('description');

/// Value with arguments
el['views']['intro']['greetings'](username: 'Jack');
el.getContent<Views>('views').getContent<ViewsIntro>('intro').getContent<Function>('greetings')(username: 'Jack');
```

## 📜 Localization content

For now you can use as a source only local `yaml` or `json` files. No remotes. Json example will be simpler, because of that let's take a look on a `yaml` localization file:

```yaml
# simple string
title: Easiest Localization App

# string with description
intro:
  value: This is a intro screen title
  # you can add a comment to any content string, like here - to a simple string
  desc: For some reason we decided to use exactly that title for that screen

# pluralized
product: &product
  zero: There are ${howMany} products
  one: There are ${howMany} product
  two: There are ${howMany} products
  few: There are ${howMany} products
  many: There are ${howMany} products
  other: There are ${howMany} products
  # Here is a comment, which will be added to generated code
  desc: How many products do we have?

# namespace
pages:
  home:
    title: Home
    description: Here you can see the main content
    counter:
      one: "You have pushed the button ${howMany} many time"
      other: "You have pushed the button ${howMany} many times"
    incrementButton:
      title: Increment
  settings:
    title: Settings
    description: Here you can change your settings
  profile:
    title:
      value: Profile
      # Here is a description too
      desc: Profile page content
    description: Here you can see your personal info and change it
  product:
    title: *product

# arguments
greetings: Hello, ${username}!

greetings2:
  value: Hello, dear ${username}!
  desc: This is greetings with an argument [username]

greetings3:
  home: Hello, ${username} at home page!
  settings: Hello, ${username} at settings page!
  custom: Hello, ${username} at ${page} page!

aboutCows:
  one: Maybe there are ${howMany} cow? What do you think, ${username}?
  other: Maybe there are ${howMany} cows? What do you think, ${username}?
```

You able to use all power of the `yaml` approach - anchors, clear and straightforward syntax, multiline strings and so on. Also, **el** allows you to nest variables each in other to have a namespaced zones. For example, you can split your localization content in the same way as it splitted in code (by domains). Like, you have some `screens` - then you can define variables of every screen under corresponding screen name and they all will be under their main parent - `screens` namespace:

```yaml
screens:
  home:
    title: abc
    description: def
    somethingElse: ghi
  settings:
    title: bcd
    description: efg
    somethingElse: hij
  # etc.
```

You, of course, able to pluralize the content. See an example above, near the comment "pluralized".
And also, you able to have any arguments (any String arguments) at your localization content:

```yaml
someKey: Hello, ${username}! What do you want to do ${day}? Will you go with me and ${friend} to the celebration? 
```

You can embed arguments to any type of content - described, pluralized and nested (inside namespaces)

## ⭐ What next?

- [x] Write tests for most critical part of the logic
- [ ] Write more additional tests
- [ ] Release 1.0.0
- [ ] Add support of dynamically retrieving of content from the remote source (with full-type safety)
- [ ] Release 2.0.0
- [ ] Something else?

If you want additional features - join to maintainers. Let's code together!

