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
