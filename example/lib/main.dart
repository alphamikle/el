import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Locale? localeOverride;

  void onLocaleSwitched(Locale locale) {
    setState(() => localeOverride = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => el.appTitle,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: localeOverride,
      home: Home(
        onLocaleSwitched: onLocaleSwitched,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    required this.onLocaleSwitched,
    super.key,
  });

  final ValueChanged<Locale> onLocaleSwitched;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late Locale selectedLocale = Localizations.localeOf(context);
  int booksAmount = 0;

  void syncLocaleWithSystem() => selectedLocale = Localizations.localeOf(context);

  Gender pickGender() => switch (booksAmount % 3) {
        0 => Gender.male,
        1 => Gender.female,
        _ => Gender.other,
      };

  void switchLanguage(Set<Locale> selected) {
    if (selected.isNotEmpty) {
      setState(() => selectedLocale = selected.first);
      widget.onLocaleSwitched(selected.first);
    }
  }

  String pickName() {
    final List<Object> names = el.employees.cast<Object>().toList();
    return names[booksAmount % names.length].toString();
  }

  void addBook() {
    setState(() {
      booksAmount++;
    });
  }

  ButtonSegment<Locale> segmentBuilder(BuildContext context, int index) {
    final Locale locale = supportedLocales[index];

    return ButtonSegment(
      value: locale,
      label: Text(
        locale.toLanguageTag(),
      ),
    );
  }

  List<Widget> text(
    String text, {
    bool last = false,
    TextStyle? style,
    bool md = false,
  }) {
    return [
      Text(
        text,
        style: style,
      ),
      if (last != true) const Divider(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    syncLocaleWithSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(el.mainScreen.greetings(username: pickName())),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...text(DateFormat(el.mainScreen.todayDateFormat).format(DateTime.now())),
          ...text(el.mainScreen.welcome, md: true),
          ...text(el.author(pickGender(), name: pickName())),
          ...text(el.privacyPolicyUrl),
          for (final Object? employee in el.employees) ...text(employee.toString()),
          ...text(
            el.mainScreen.books.amountOfNew(booksAmount),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...text(el.language(language: selectedLocale.languageCode, country: selectedLocale.countryCode ?? '')),
          ...text(el.source),
          SegmentedButton<Locale>(
            segments: List.generate(supportedLocales.length, (int index) => segmentBuilder(context, index)),
            selected: {selectedLocale},
            onSelectionChanged: switchLanguage,
            emptySelectionAllowed: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addBook,
        tooltip: el.mainScreen.books.add,
        child: const Icon(Icons.add),
      ),
    );
  }
}
